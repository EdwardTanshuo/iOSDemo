//
//  LiveManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "YUGPUImageCVPixelBufferInput.h"
#import "GPUImageBeautifyFilter.h"


@protocol LiveDataSourceDelegate
- (void) recieveStichedFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp;
- (void) recieveOnRawFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp;
- (void) recieveError:(NSError *)error;
@end


@interface LiveManager : NSObject

@property (nonatomic, weak) id<LiveDataSourceDelegate> delegate;
@property (nonatomic,strong) YUGPUImageCVPixelBufferInput *pixelBufferInput;
@property (nonatomic, strong) GPUImageBeautifyFilter* filter;

#pragma mark singleton
+ (LiveManager*)sharedManager;

#pragma mark public methods
- (void)startLiveWithView: (GPUImageView*) view;
- (void)stopLive;

@end

