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
#import "DanmuManager.h"
#import "GameManager.h"

@interface LiveManager()<INSLiveDataSourceProtocol, FaceDetectManagerDelegate>{
    CVPixelBufferRef m_pixelBuffer;
    CVPixelBufferRef m_faceBuffer;
    __weak GPUImageView* pano;
}

@property (nonatomic, strong) INSLiveDataSource* liveDataSource;
@property (nonatomic, weak)   GPUImageView*                     view;
@property (nonatomic, strong) GPUImageRawDataOutput*            output;
@property (nonatomic, strong) GPUImageRawDataOutput*            face_output;
@property (nonatomic, strong) YUGPUImageCVPixelBufferInput*     pixelBufferInput;
@property (nonatomic, strong) YUGPUImageCVPixelBufferInput*     faceInput;
@property (nonatomic, strong) GPUImageHSBFilter*                filter;

@property (nonatomic, assign) NSInteger current_frame;
@property (nonatomic, strong) dispatch_semaphore_t frameRenderingSemaphore;
@property (nonatomic, strong) dispatch_semaphore_t frameFaceSemaphore;
@property (nonatomic, strong) INSFlatLiveStreamer* real_streamer;
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
    [self parseFaceBuffer: pixelBuffer];
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
    self.faceInput = [[YUGPUImageCVPixelBufferInput alloc] init];
    [self.pixelBufferInput forceProcessingAtSize:CGSizeMake(setting.width, setting.height)];
    [self.faceInput forceProcessingAtSize:CGSizeMake(setting.width, setting.height)];
    
    // Adjust HSB
    self.filter = [[GPUImageHSBFilter alloc] init];
    [self.filter adjustBrightness:(setting.brightness + 1.0)];
    [self.filter adjustSaturation:(setting.brightness + 1.0)];
    
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
    
    //danmu
    [[DanmuManager sharedManager] connect];
    
    
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
            [self startLiveWithWidth:setting.width WithHeight:setting.height WithBitrate:setting.bitrate WithQuality:INSCameraVideoResType_1440_720P30];
            [[StreamManager sharedManager] startRTMP];
            break;
        case SettingSessionCameraQualityMedium:
            [self startLiveWithWidth:setting.width WithHeight:setting.height WithBitrate:setting.bitrate WithQuality:INSCameraVideoResType_2160_1080P30];
            [[StreamManager sharedManager] startRTMP];
            break;
        case SettingSessionCameraQualityHigh:
            [self startLiveWithWidth:setting.width WithHeight:setting.height WithBitrate:setting.bitrate WithQuality:INSCameraVideoResType_3040_1520P30];
            [[StreamManager sharedManager] startRTMP];
            break;
        case SettingSessionCameraQualityReal:
            _real_streamer = [[INSFlatLiveStreamer alloc] initWithRtmpAddress:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", setting.url, setting.streamKey]] cameraResolution:INSCameraVideoResType_3040_1520P30 stitchWidth:setting.width stitchHeight:setting.height bitrate:setting.bitrate];
            //_real_streamer = [[INSFlatLiveStreamer alloc] initWithRtmpAddress:[NSURL URLWithString:[NSString stringWithFormat:@"rtmp://10.10.17.182:1935/rtmplive/kjkjkj"]] cameraResolution:INSCameraVideoResType_3040_1520P30 stitchWidth:setting.width stitchHeight:setting.height bitrate:setting.bitrate];
           
            [_real_streamer startLive];
            self.isLiving = YES;
            break;
        default:
            break;
    }
    
    
}

- (void)stopLive{
    if(!self.isLiving){
        return;
    }
    //允许休眠
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    
    //danmu
    [[DanmuManager sharedManager] disconnect];
    
    self.isLiving = NO;
    
    if(self.real_streamer){
        [_real_streamer stopLive];
        self.isLiving = NO;
        return;
    }
    
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
    
    [self.pixelBufferInput removeTarget: self.filter];
    [self.filter removeTarget:self.output];
    
    //remove face detector
    if(setting.faceDetectOn){
        [self.faceInput removeTarget:self.face_output];
    }
}

- (void)setupPipes{
    SettingSession* setting = [SettingSession new];
    
    [self.pixelBufferInput addTarget: self.filter];
    [self.filter addTarget:self.output];
    
    //add face detector
    if(setting.faceDetectOn){
        [self.faceInput addTarget: self.face_output];
    }
}

- (void)parsePixelBuffer:(CVPixelBufferRef)pixelBuffer{
    [self.pixelBufferInput processCVPixelBuffer:pixelBuffer];
}

- (void)parseFaceBuffer:(CVPixelBufferRef)pixelBuffer{
    [self.faceInput processCVPixelBuffer:pixelBuffer];
}

- (void) pudgeOutput: (GPUImageRawDataOutput*)output buffer: (CVPixelBufferRef)buffer semaphore: (dispatch_semaphore_t)semaphore{
    [output unlockFramebufferAfterReading];
    dispatch_semaphore_signal(semaphore);
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
- (void)faceHasBeenDetected:(NSArray *)features size:(CGSize)size{
    __weak LiveManager* wself = self;
    LogMessage(@"face", 0, @"detector callback: %ld faces has been detected", [features count]);
    for (CIFaceFeature *f in features) {
        //send info to server
        [[GameManager sharedManager] sendFaceCoordinate:@{@"lex": @(f.leftEyePosition.x), @"ley": @(f.leftEyePosition.y), @"rex": @(f.rightEyePosition.x), @"rey": @(f.rightEyePosition.y), @"mpx": @(f.mouthPosition.x), @"mpy": @(f.mouthPosition.y), @"bounds": @[@(f.bounds.size.width), @(f.bounds.size.height)], @"size": @[@(size.width), @(size.height)]}];
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate recieveFaceCoor:f.bounds];
        });
    }
    
    //clean buffer
    [self pudgeOutput:self.face_output buffer:m_faceBuffer semaphore:self.frameFaceSemaphore];
}

@end

