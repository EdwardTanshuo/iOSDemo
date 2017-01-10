//
//  FaceDetectManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/23/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "FaceDetectManager.h"
#import "FaceDetector.h"

@interface FaceDetectManager()
@property (nonatomic, strong) FaceDetector* detector;
@end

@implementation FaceDetectManager
#pragma mark singleton
+ (FaceDetectManager* _Nonnull)sharedManager {
    static FaceDetectManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init{
    self.detector = [[FaceDetector alloc] init];
    return [super init];
}

- (void)appendBuffer: (CVPixelBufferRef)buffer{
    size_t width = CVPixelBufferGetWidth(buffer) / [UIScreen mainScreen].scale;
    size_t height = CVPixelBufferGetHeight(buffer) / [UIScreen mainScreen].scale;
    NSArray* features = [self.detector DetectFaceFromBuffer:buffer];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [_delegate faceHasBeenDetected:features size:CGSizeMake(width, height)];
    });
}
@end
