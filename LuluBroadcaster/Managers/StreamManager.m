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
    _isStreaming = YES;
}

- (void)stopRTMP{
    if (!_isStreaming)
        return;
    _isStreaming = NO;
    [self stopSessionLive];
}

#pragma mark -
#pragma mark session
- (LFLiveSession*)session {
    if (!_session) {
        SettingSession* setting = [SettingSession new];
        
        LFLiveVideoConfiguration* configuration = [LFLiveVideoConfiguration new];
        
        configuration.videoFrameRate = setting.fps;
        configuration.videoMaxFrameRate = setting.fps + 5;
        configuration.videoMinFrameRate = setting.fps - 5;
        configuration.videoBitRate = setting.bitrate;
        configuration.videoMaxBitRate = setting.bitrate * 1.2;
        configuration.videoMinBitRate = setting.bitrate * 0.8;
        configuration.videoSize = CGSizeMake(setting.width, setting.height);
        configuration.outputImageOrientation = UIInterfaceOrientationLandscapeLeft;
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:configuration captureType:LFLiveCaptureMaskAudioInputVideo];
        
        _session.delegate = self;
    }
    return _session;
}

- (void)startSessionLive {
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    SettingSession* setting = [[SettingSession alloc] init];
    streamInfo.url = [NSString stringWithFormat:@"%@/%@", setting.url, setting.streamKey];
    //streamInfo.url = @"rtmp://10.10.17.182:1935/rtmplive/kjkjkj";
    [self.session startLive:streamInfo];
    [self.session setRunning:YES];
}

- (void)stopSessionLive {
    [self.session setRunning:NO];
    [self.session stopLive];
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
