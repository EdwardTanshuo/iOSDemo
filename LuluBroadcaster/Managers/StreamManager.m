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

@interface StreamManager()<INSLiveStreamerStateDelegate>

@property (nonatomic, strong) INSLiveDataSource* liveDataSource;

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

- (void) dealloc{
    [[INSCameraAccessory defaultCamera] removeObserver:self forKeyPath:@"status"];
}

#pragma mark -
#pragma mark INSLiveStreamerStateDelegate

- (void)streamer:(id<INSLiveStreamer>)streamer onError:(NSError*)error {
    
}

- (void)streamerOnStart:(id<INSLiveStreamer>)streamer {
    
}

- (void)streamerOnStop:(id<INSLiveStreamer>)streamer {
    
}
- (void)streamerOnLiveFps:(double)fps duration:(double)duration{
    
}



@end
