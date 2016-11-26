//
//  StreamManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "StreamManager.h"
#import "SettingSession.h"
#import <INSNanoSDK/INSNanoSDK.h>
#import <NSLogger/NSLogger.h>

#define AUDIO_DEF_SAMPLERATE 22050
#define AUDIO_DEF_CHANNELNUM 2
#define AUDIO_DEF_BITRATE    64000

#define VIDEO_SIZE_CIF CGSizeMake(960, 480) //推荐600kbps， 25帧
#define VIDEO_SIZE_D1  CGSizeMake(540, 960) //推荐800kbps, 25帧
//不推荐手机做720P直播，WIFI信号不稳定，会导致上行速率波动，效果不好

#define BITRATE_CIF (500*1024)
#define BITRATE_D1  (800*1000)

@interface StreamManager(){
    CVPixelBufferRef m_buffer;
}
@property (nonatomic, strong) dispatch_semaphore_t bufferCopySemaphore;
@property (nonatomic, strong) NSTimer* timer;
@end

@implementation StreamManager
#pragma mark singleton
+ (StreamManager*)sharedManager {
    static StreamManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

- (instancetype)init{
    //initilaize buffer
    m_buffer = NULL;
    self.bufferCopySemaphore = dispatch_semaphore_create(1);
    
    _isStreaming = NO;
   
    return [super init];
}


- (void) dealloc{
    CFRelease(CFRelease);
}

#pragma mark -
#pragma mark methods
- (void)rtmpProcess{
    LogMessage(@"debug", 0, @"stepa");
    //dispatch_semaphore_wait(self.bufferCopySemaphore, DISPATCH_TIME_NOW);
    if(m_buffer){
        //CVPixelBufferLockBaseAddress(m_buffer, kCVPixelBufferLock_ReadOnly);
        LogMessage(@"debug", 0, @"stepb");
        [self.session PutBuffer:m_buffer];
        LogMessage(@"debug", 0, @"stepc");
        //CVPixelBufferUnlockBaseAddress(m_buffer, kCVPixelBufferLock_ReadOnly);
        LogMessage(@"debug", 0, @"stepd");
    }
    //dispatch_semaphore_signal(self.bufferCopySemaphore);
}

- (void)startRTMP{
    if (_session)
        return;
    self.session = [[VCRtmpSession alloc] initWithVideoSize:VIDEO_SIZE_CIF fps:12 bitrate:BITRATE_CIF];
    SettingSession* setting = [[SettingSession alloc] init];
    [self.session startRtmpSession:@"rtmp://10.10.17.182:1935/rtmplive/kjkjkj"];
    //[self.session startRtmpSession:[NSString stringWithFormat:@"%@/%@", setting.url, setting.streamKey]];
    //_timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(rtmpProcess) userInfo:nil repeats:YES];
    _isStreaming = YES;
}

- (void)stopRTMP{
    if (!_session)
        return;
    _isStreaming = NO;
    [self.session endRtmpSession];
    self.session = nil;
    //[_timer invalidate];
}

- (void)refreshBuffer: (CVPixelBufferRef)new_buffer{
    //dispatch_semaphore_wait(self.bufferCopySemaphore, DISPATCH_TIME_NOW);
    LogMessage(@"debug", 0, @"step1");
    // Get pixel buffer info
    CVPixelBufferLockBaseAddress(new_buffer, kCVPixelBufferLock_ReadOnly);
    CVPixelBufferLockBaseAddress(m_buffer, kCVPixelBufferLock_ReadOnly);
    LogMessage(@"debug", 0, @"step2");
    size_t sizeToCopy = CVPixelBufferGetDataSize(new_buffer);
    int bufferWidth = (int)CVPixelBufferGetWidth(new_buffer);
    int bufferHeight = (int)CVPixelBufferGetHeight(new_buffer);
    uint8_t *baseAddress = CVPixelBufferGetBaseAddress(new_buffer);
    LogMessage(@"debug", 0, @"step3");
    //clean the old buffer
    if(m_buffer){
        CFRelease(m_buffer);
        m_buffer = NULL;
    }
    LogMessage(@"debug", 0, @"step4");
    // Copy the pixel buffer
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, bufferWidth, bufferHeight, kCVPixelFormatType_32BGRA, NULL, &m_buffer);
    LogMessage(@"debug", 0, @"step5");
    uint8_t *copyBaseAddress = CVPixelBufferGetBaseAddress(m_buffer);
    memcpy(copyBaseAddress, baseAddress, sizeToCopy);
    LogMessage(@"debug", 0, @"step6");
    CVPixelBufferUnlockBaseAddress(m_buffer, kCVPixelBufferLock_ReadOnly);
    CVPixelBufferUnlockBaseAddress(new_buffer, kCVPixelBufferLock_ReadOnly);
    //dispatch_semaphore_signal(self.bufferCopySemaphore);
}


@end
