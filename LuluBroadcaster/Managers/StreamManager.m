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

@interface StreamManager()<LFLiveSessionDelegate>{
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

- (void)startRTMP{
    if (_isStreaming)
        return;
    [self startSessionLive];
    //_timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(rtmpProcess) userInfo:nil repeats:YES];
    _isStreaming = YES;
}

- (void)stopRTMP{
    if (!_isStreaming)
        return;
    _isStreaming = NO;
    [self stopSessionLive];
    //[_timer invalidate];
}

#pragma mark -
#pragma mark session
- (LFLiveSession*)session {
    if (!_session) {
        LFLiveVideoConfiguration* configuration = [LFLiveVideoConfiguration new];
        configuration.sessionPreset = LFCaptureSessionPreset540x960;
        configuration.videoFrameRate = 20;
        configuration.videoMaxFrameRate = 25;
        configuration.videoMinFrameRate = 10;
        configuration.videoBitRate = 800 * 1000;
        configuration.videoMaxBitRate = 960 * 1000;
        configuration.videoMinBitRate = 500 * 1000;
        configuration.videoSize = CGSizeMake(960, 480);
        configuration.outputImageOrientation = UIInterfaceOrientationLandscapeLeft;
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:configuration captureType:LFLiveCaptureMaskAudioInputVideo];
        
        _session.delegate = self;
    }
    return _session;
}

- (void)startSessionLive {
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    //[self.session startRtmpSession:[NSString stringWithFormat:@"%@/%@", setting.url, setting.streamKey]];
    streamInfo.url = @"rtmp://10.10.17.182:1935/rtmplive/kjkjkj";
    [self.session startLive:streamInfo];
    [self.session setRunning:YES];
}

- (void)stopSessionLive {
    [self.session stopLive];
    [self.session setRunning:NO];
}


#pragma mark-
#pragma mark--LFLiveSessionDelegate
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    LogMessage(@"stream", 0, @"%lu", (unsigned long)state);
}

/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug *)debugInfo{
    LogMessage(@"stream", 0, @"%@", debugInfo);
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode{
    LogMessage(@"stream", 0, @"%lu", (unsigned long)errorCode);
}

@end
