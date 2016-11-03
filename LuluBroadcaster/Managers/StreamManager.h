//
//  StreamManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol StreamManagerDelegate

@end


@interface StreamManager : NSObject

@property (nonatomic, weak) id<StreamManagerDelegate> delegate;

#pragma mark singleton
+ (StreamManager*)sharedManager;

#pragma mark public methods
- (void)startRTMP;
- (void)appendBuffer:(CVPixelBufferRef)buffer;
- (void)stopRTMP;
@end
