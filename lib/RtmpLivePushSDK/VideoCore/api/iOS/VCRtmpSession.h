//
//  VCRtmpSession.h
//  RtmpLivePushSDK
//
//  Created by 施维 on 16/6/14.
//  Copyright © 2016年 com.Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface VCRtmpSession : NSObject

/*! Setters / Getters for session properties */
@property (nonatomic, assign) CGSize            videoSize;      // Change will not take place until the next RTMP Session
@property (nonatomic, assign) int               bitrate;        // Change will not take place until the next RTMP Session
@property (nonatomic, assign) int               fps;            // Change will not take place until the next RTMP

-(VCRtmpSession*)initWithVideoSize:(CGSize)videoSize
                               fps:(CGFloat)fFps
                           bitrate:(CGFloat)fBitRate;

- (void) startRtmpSession:(NSString *)rtmpUrl;

- (void) endRtmpSession;

- (void)PutBuffer:(CVPixelBufferRef)pixelBuff;

@end
