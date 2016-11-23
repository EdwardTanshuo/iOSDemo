//
//  FaceDetector.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/23/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "FaceDetector.h"
#import <ImageIO/ImageIO.h>
@interface FaceDetector ()
@property (nonatomic, strong) CIDetector* faceDetector;
@end

@implementation FaceDetector
- (instancetype)init{
    NSDictionary *detectorOptions = [[NSDictionary alloc] initWithObjectsAndKeys:CIDetectorAccuracyLow, CIDetectorAccuracy, nil];
    _faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];
    return [super init];
}

- (NSArray*)DetectFaceFromBuffer:(CVPixelBufferRef)buffer{
    CVPixelBufferLockBaseAddress(buffer, kCVPixelBufferLock_ReadOnly);
    CIImage* ciImage = [[CIImage alloc] initWithCVPixelBuffer:buffer];
    //[[ciImage properties] valueForKey:(NSString *)kCGImagePropertyOrientation];
    NSDictionary *imageOptions = @{CIDetectorImageOrientation : @(1)};
    
    NSArray *features = [self.faceDetector featuresInImage:ciImage
                                                   options:imageOptions];
   
    CVPixelBufferUnlockBaseAddress(buffer, kCVPixelBufferLock_ReadOnly);
    CFRelease(buffer);
    return features;
}
@end
