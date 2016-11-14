//
//  LiveManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



@protocol LiveDataSourceDelegate
- (void) recieveStichedFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp;
- (void) recieveOnRawFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp;
- (void) recieveError:(NSError *)error;
@end


@interface LiveManager : NSObject
@property (nonatomic, assign) BOOL isLiving;
@property (nonatomic, weak) id<LiveDataSourceDelegate> delegate;


#pragma mark singleton
+ (LiveManager*)sharedManager;

#pragma mark public methods
- (void)startLiveWithView: (UIView*) view;
- (void)stopLive;

@end

