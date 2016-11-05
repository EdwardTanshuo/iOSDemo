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
#import "GPUImage.h"

@protocol StreamManagerDelegate
- (void)ready;
- (void)started;
- (void)failed;
- (void)pending;
- (void)stop;
- (void)error: (LFLiveSocketErrorCode)code;
- (void)debug: (nullable LFLiveDebug *)debugInfo;
- (void)bufferFetched: (CVPixelBufferRef)buffer;
@end


@interface StreamManager : NSObject
@property (nonatomic, weak) id<StreamManagerDelegate> delegate;
@property (nonatomic, assign) BOOL isStreaming;
#pragma mark singleton
+ (StreamManager*)sharedManager;

#pragma mark public methods
- (void)startRTMP;
- (void)appendVideoBuffer:(CVPixelBufferRef)buffer;
- (void)appendAudioBuffer:(NSData*)buffer;
- (void)stopRTMP;
- (void)processVideo:(GPUImageOutput*)output;
@end
