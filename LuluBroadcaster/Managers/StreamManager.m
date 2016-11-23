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

@interface StreamManager()

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
    self.session = [[VCRtmpSession alloc] initWithVideoSize:VIDEO_SIZE_CIF fps:20 bitrate:BITRATE_CIF];
    return [super init];
}


- (void) dealloc{
    
}

#pragma mark -
#pragma mark methods
- (void)startRTMP{
    if (!_session)
        return;
    SettingSession* setting = [[SettingSession alloc] init];
    [self.session startRtmpSession:@"rtmp://10.10.17.182:1935/rtmplive/kjkjkj"];
    //[self.session startRtmpSession:[NSString stringWithFormat:@"%@/%@", setting.url, setting.streamKey]];
    _isStreaming = YES;
}

- (void)stopRTMP{
    if (!_session)
        return;
    _isStreaming = NO;
    [self.session endRtmpSession];
    
}


@end
