//
//  StreamManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <LFLiveKit/LFLiveKit.h>

@protocol StreamManagerDelegate
- (void)ready;
- (void)started;
- (void)failed;
- (void)pending;
- (void)stop;
- (void)bufferFetched: (CVPixelBufferRef)buffer;
@end


@interface StreamManager : NSObject
@property (nonatomic, weak) id<StreamManagerDelegate> delegate;
@property (nonatomic, assign) BOOL isStreaming;
@property (nonatomic, strong) LFLiveSession* session;

#pragma mark singleton
+ (StreamManager*)sharedManager;

#pragma mark public methods
- (void)startRTMP;
- (void)stopRTMP;

@end
