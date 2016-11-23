//
//  FaceDetector.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/23/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface FaceDetector : NSObject
- (NSArray*)DetectFaceFromBuffer:(CVPixelBufferRef)buffer;
@end
