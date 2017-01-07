//
//  FaceDetectManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/23/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FaceDetectManagerDelegate
- (void)faceHasBeenDetected: (NSArray* _Nonnull)features
                       size: (CGSize)size;
@end

@interface FaceDetectManager : NSObject
@property (nonatomic, weak, nullable) id<FaceDetectManagerDelegate> delegate;
+ (FaceDetectManager* _Nonnull)sharedManager;
- (void)appendBuffer: (CVPixelBufferRef _Nonnull)buffer;
@end
