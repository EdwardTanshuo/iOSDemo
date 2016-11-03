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
#import "LFLiveKit.h"

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
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        _session.delegate = self;
    }
    return [super init];
}

- (void) dealloc{
    
}

#pragma mark -
#pragma mark LFLiveSessionDelegate
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange: (LFLiveState)state{
}
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
}
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
}

#pragma mark -
#pragma mark methods
- (void)startRTMP{
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    streamInfo.url = @"your server rtmp url";
    [self.session startLive:streamInfo];
}

- (void)stopRTMP{
    [self.session stopLive];
}

- (void)appendBuffer:(CVPixelBufferRef)buffer {
    [self.session pushVideo:buffer];
    CVPixelBufferRelease(buffer);
}


@end
