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

#define NOW [[NSDate new] timeIntervalSince1970]


@interface StreamManager()<LFLiveSessionDelegate>
@property (nonatomic, strong) LFLiveSession* session;
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
    _isStreaming = NO;
    LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
    audioConfiguration.numberOfChannels = 2;
    audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
    audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
    
    LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
    videoConfiguration.videoSize = CGSizeMake(3040, 1520);
    videoConfiguration.videoBitRate = 2 * 1024 * 1024;
    videoConfiguration.videoMaxBitRate = 3 * 1024 * 1024;
    videoConfiguration.videoMinBitRate = 1 * 1024 * 1024;
    videoConfiguration.videoFrameRate = 30;
    videoConfiguration.videoMaxKeyframeInterval = 30;
    videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
    self.session = [[LFLiveSession alloc]initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:videoConfiguration];
    _session.running = YES;
    self.session.delegate = self;
    return [super init];
}

- (void) dealloc{
    
}

#pragma mark -
#pragma mark VCSessionDelegate
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    switch (state) {
        case LFLiveReady:
            [_delegate ready];
            break;
        case LFLiveStart:
            [_delegate started];
            break;
        case LFLiveError:
            [_delegate failed];
            break;
        case LFLivePending:
            [_delegate pending];
            break;
        case LFLiveStop:
            [_delegate stop];
            break;
        default:
            break;
    }
}
/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug *)debugInfo{
    [_delegate debug:debugInfo];
}
/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode{
    [_delegate error:errorCode];
}

#pragma mark -
#pragma mark methods
- (void)startRTMP{
    if (!_session)
        return;
    SettingSession* setting = [[SettingSession alloc] init];
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    streamInfo.url = setting.url;
    streamInfo.streamId = setting.streamKey;
    
    [self.session startLive:streamInfo];
    _isStreaming = YES;
}

- (void)stopRTMP{
    if (!_session)
        return;
    _isStreaming = NO;
    [self.session stopLive];
}


- (void)appendVideoBuffer:(CVPixelBufferRef)buffer {
    if (!_session || !_isStreaming)
        return;
    [self.session pushVideo:buffer];
}

- (void)appendAudioBuffer:(NSData*)buffer{
    //[self.session end];
    if (!_session || !_isStreaming)
        return;
    [self.session pushAudio:buffer];
}

@end
