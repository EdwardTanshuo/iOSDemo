//
//  StreamManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "LFLiveKit.h"

@protocol StreamManagerDelegate
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange: (LFLiveState)state;
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo;
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode;
@end


@interface StreamManager : NSObject

@property (nonatomic, weak) id<StreamManagerDelegate> delegate;

#pragma mark singleton
+ (StreamManager*)sharedManager;

#pragma mark public methods
- (void)startRTMP;
- (void)appendVideoBuffer:(CVPixelBufferRef)buffer;
- (void)appendAudioBuffer:(NSData*)buffer;
- (void)stopRTMP;
@end
