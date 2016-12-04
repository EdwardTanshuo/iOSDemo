//
//  LiveManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//



#import "LiveManager.h"
#import "SettingSession.h"
#import "StreamManager.h"
#import "FaceDetectManager.h"
#import <GPUImage/GPUImageFramework.h>
#import <INSNanoSDK/INSNanoSDK.h>
#import "YUGPUImageCVPixelBufferInput.h"
#import "GPUImageMyBeautifyFilter.h"
#import "LFGPUImageBeautyFilter.h"
#import <NSLogger/NSLogger.h>


@interface LiveManager()<INSLiveDataSourceProtocol, FaceDetectManagerDelegate>{
    CVPixelBufferRef m_pixelBuffer;
    CVPixelBufferRef m_faceBuffer;
    __weak GPUImageView* pano;
}

@property (nonatomic, strong) INSLiveDataSource* liveDataSource;
@property (nonatomic, weak)   GPUImageView* view;
@property (nonatomic, strong) GPUImageRawDataOutput* output;
@property (nonatomic, strong) GPUImageRawDataOutput* face_output;
@property (nonatomic, strong) YUGPUImageCVPixelBufferInput *pixelBufferInput;
@property (nonatomic, strong) GPUImageBrightnessFilter* filter;
@property (nonatomic, strong) GPUImageTransformFilter* scaler;

@property (nonatomic, assign) NSInteger current_frame;
@property (nonatomic, strong) dispatch_semaphore_t frameRenderingSemaphore;
@property (nonatomic, strong) dispatch_semaphore_t frameFaceSemaphore;
@end

@implementation LiveManager
#pragma mark singleton
+ (LiveManager*)sharedManager {
    static LiveManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init{
    return [super init];
    
}

- (void) dealloc{
    [[INSCameraAccessory defaultCamera] removeObserver:self forKeyPath:@"status"];
}

- (void) pudgeOutput: (GPUImageRawDataOutput*)output buffer: (CVPixelBufferRef)buffer semaphore: (dispatch_semaphore_t)semaphore{
    [output unlockFramebufferAfterReading];
    dispatch_semaphore_signal(semaphore);
}



#pragma mark -
#pragma mark INSLiveDataSourceProtocol

- (void) sourceOnError:(NSError *)error{
    [_delegate recieveError:error];
}

- (void) sourceOnH264Header:(const uint8_t *)sps spsSize:(size_t)spsSize pps:(const uint8_t *)pps ppsSize:(size_t)ppsSize{
}

- (void) sourceOnH264Nalu:(NSData *)nalu keyFrame:(BOOL)isKey timestamp:(int64_t)timestamp{
    
}

- (void) sourceOnAACHeader:(const uint8_t *)aacHeader size:(size_t)headerSize{
    
}

- (void) sourceOnAACData:(const uint8_t *)aacData size:(size_t)size timestamp:(int64_t)timestamp{
    
}

- (void) sourceOnH264Nalu:(const uint8_t *)nalu size:(size_t)size keyFrame:(BOOL)isKey timestamp:(int64_t)timestamp{
    
}


- (void) sourceOnAACData:(NSData *)aacData timestamp:(int64_t)timestamp{
    
}

- (void) sourceOnRawPixelBuffer:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
    [_delegate recieveOnRawFragment:pixelBuffer timestamp:timestamp];
}

- (void) sourceOnStitchPixelBuffer:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
    [self parsePixelBuffer: pixelBuffer];
    [_delegate recieveStichedFragment:pixelBuffer timestamp:timestamp];
}

#pragma mark methods
- (void)setupLive{
    SettingSession* setting = [SettingSession new];
    
    m_pixelBuffer = NULL;
    m_faceBuffer = NULL;
    __weak LiveManager* wself = self;
    
    [FaceDetectManager sharedManager].delegate = self;
    
    self.frameRenderingSemaphore = dispatch_semaphore_create(1);
    self.frameFaceSemaphore = dispatch_semaphore_create(1);
    
    self.isLiving = NO;
    self.current_frame = 0;
    
    self.pixelBufferInput = [[YUGPUImageCVPixelBufferInput alloc] init];
    
    self.filter = [[GPUImageBrightnessFilter alloc] init];
    [self.filter setBrightness:setting.brightness];
    
    _output = [[GPUImageRawDataOutput alloc] initWithImageSize:CGSizeMake(setting.width, setting.height) resultsInBGRAFormat:YES];
    __weak GPUImageRawDataOutput *weakOutput = _output;
    CVPixelBufferRef* buffer = &m_pixelBuffer;
    [_output setNewFrameAvailableBlock:^{
        if(!wself){
            return;
        }
        if (dispatch_semaphore_wait(wself.frameRenderingSemaphore, DISPATCH_TIME_NOW) != 0) {
            return;
        }
        __strong GPUImageRawDataOutput *strongOutput = weakOutput;
        [strongOutput lockFramebufferForReading];
        GLubyte *outputBytes = [strongOutput rawBytesForImage];
        NSInteger bytesPerRow = [strongOutput bytesPerRowInOutput];
        CVPixelBufferCreateWithBytes(kCFAllocatorDefault, setting.width, setting.height, kCVPixelFormatType_32BGRA, outputBytes, bytesPerRow, nil, nil, nil, buffer);
        [wself PixelBufferCallback:*buffer];;
        CFRelease(*buffer);
        [strongOutput unlockFramebufferAfterReading];
        dispatch_semaphore_signal(wself.frameRenderingSemaphore);
        
    }];
    
    _face_output = [[GPUImageRawDataOutput alloc] initWithImageSize:CGSizeMake(setting.width, setting.height) resultsInBGRAFormat:YES];
    __weak GPUImageRawDataOutput *weakFaceOutput = _face_output;
    CVPixelBufferRef* face_buffer = &m_faceBuffer;
    [_face_output setNewFrameAvailableBlock:^{
        if(!wself){
            return;
        }
        if (dispatch_semaphore_wait(wself.frameFaceSemaphore, DISPATCH_TIME_NOW) != 0) {
            return;
        }
        __strong GPUImageRawDataOutput *strongOutput = weakFaceOutput;
        [strongOutput lockFramebufferForReading];
        GLubyte *outputBytes = [strongOutput rawBytesForImage];
        NSInteger bytesPerRow = [strongOutput bytesPerRowInOutput];
        CVPixelBufferCreateWithBytes(kCFAllocatorDefault, setting.width, setting.height, kCVPixelFormatType_32BGRA, outputBytes, bytesPerRow, nil, nil, nil, face_buffer);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [[FaceDetectManager sharedManager] appendBuffer:*face_buffer];
        });
    }];
    
    self.scaler = [[GPUImageTransformFilter alloc] init];
    [self.scaler forceProcessingAtSizeRespectingAspectRatio:CGSizeMake(setting.width, setting.height)];
}

- (void)startLiveWithWidth:(NSInteger)stitchWidth WithHeight:(NSInteger)stitchHeight WithBitrate:(NSInteger)bitrate WithQuality: (INSCameraVideoResType)quality{
    self.liveDataSource = [[INSLiveDataSource alloc] initWitCameraResolution:quality stitchWidth:stitchWidth stitchHeight:stitchHeight bitrate:bitrate];
    self.liveDataSource.dataSourceDelegate = self;
    [self.liveDataSource start];
}


- (void)startLiveWithView: (UIView*) view{
    if(self.isLiving){
        return;
    }
    
    //设置参数
    [self setupLive];
    
    //禁止休眠
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    self.isLiving = YES;
    [self setupPipes];
    GPUImageView* g_v = (GPUImageView*)view;
    self.view = g_v;
    if(view){
        [self.filter addTarget:g_v];
    }
    
    //设置相机
    SettingSession* setting = [SettingSession new];
    switch (setting.quality) {
        case SettingSessionCameraQualityLow:
            [self startLiveWithWidth:1440 WithHeight:720 WithBitrate:600 * 1024 WithQuality:INSCameraVideoResType_1440_720P30];
            break;
        case SettingSessionCameraQualityMedium:
            [self startLiveWithWidth:2160 WithHeight:1080 WithBitrate:2 * 1024 * 1024 WithQuality:INSCameraVideoResType_2160_1080P30];
            break;
        case SettingSessionCameraQualityHigh:
            [self startLiveWithWidth:3040 WithHeight:1520 WithBitrate:8 * 1024 * 1024 WithQuality:INSCameraVideoResType_3040_1520P30];
            break;
        default:
            break;
    }
    
    [[StreamManager sharedManager] startRTMP];
}

- (void)stopLive{
    if(!self.isLiving){
        return;
    }
    //允许休眠
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    
    self.isLiving = NO;
    if(self.view){
        [self.filter removeTarget:self.view];
    }
    [self tearDown];
    [self.liveDataSource stop];
    self.liveDataSource = nil;
    [[StreamManager sharedManager] stopRTMP];
}

- (void)tearDown{
    SettingSession* setting = [SettingSession new];
    
    [self.pixelBufferInput removeTarget: self.scaler];
    [self.scaler removeTarget:self.filter];
    
    //remove face detector
    if(setting.faceDetectOn){
        [self.scaler removeTarget:self.face_output];
    }
    
    [self.filter removeTarget:self.output];
}

- (void)setupPipes{
    SettingSession* setting = [SettingSession new];
    
    [self.pixelBufferInput addTarget: self.scaler];
    [self.scaler addTarget:self.filter];
    
    //add face detector
    if(setting.faceDetectOn){
        [self.scaler addTarget:self.face_output];
    }
    
    [self.filter addTarget:self.output];
}

- (void)parsePixelBuffer:(CVPixelBufferRef)pixelBuffer{
    [self.pixelBufferInput processCVPixelBuffer:pixelBuffer];
}

#pragma mark-
#pragma mark--视频数据处理回调
-(void)PixelBufferCallback:(CVPixelBufferRef)pixelFrameBuffer{
    _current_frame++;
    
    if([StreamManager sharedManager].session && [StreamManager sharedManager].isStreaming && self.isLiving){
        [[StreamManager sharedManager].session pushVideo:pixelFrameBuffer];
    }
}

#pragma mark-
#pragma mark--FaceDetectManagerDelegate
- (void)faceHasBeenDetected:(NSArray *)features{
    LogMessage(@"face", 0, @"detector callback: %ld faces has been detected", [features count]);
    for (CIFaceFeature *f in features) {
        if (f.hasLeftEyePosition) {
            LogMessage(@"face", 0, @"Left eye %g %g", f.leftEyePosition.x, f.leftEyePosition.y);
        }
        if (f.hasRightEyePosition) {
            LogMessage(@"face", 0, @"Right eye %g %g", f.rightEyePosition.x, f.rightEyePosition.y);
        }
        if (f.hasMouthPosition) {
            LogMessage(@"face", 0, @"Mouth %g %g", f.mouthPosition.x, f.mouthPosition.y);
        }
    }
    [self pudgeOutput:self.face_output buffer:m_faceBuffer semaphore:self.frameFaceSemaphore];
}


@end

