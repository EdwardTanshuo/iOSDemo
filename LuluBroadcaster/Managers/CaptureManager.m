//
//  CaptureManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/7/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "CaptureManager.h"
#import <AVFoundation/AVFoundation.h>

@interface CaptureManager(){
    AVCaptureSession* session;
    AVCapturePhotoOutput* output;
    AVCaptureVideoPreviewLayer* layer;
    
    AVCaptureDevice* device;
    AVCaptureDeviceInput* input;
    
    
}
@end


@implementation CaptureManager
+ (CaptureManager* _Nonnull)sharedManager{
    static CaptureManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
    
- (instancetype)init
{
    self = [super init];
    if (self) {
            
    }
    return self;
}

- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *iter in devices) {
        if ([iter position] == AVCaptureDevicePositionFront) {
            return iter;
        }
    }
    return nil;
}
    
- (void)setupUtils{
    if(_preView == nil){
        return;
    }
    
    session = [AVCaptureSession new];
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice* frontCamera = [self frontCamera];
    device = frontCamera;
    NSError* err = nil;
    input = [AVCaptureDeviceInput deviceInputWithDevice:frontCamera error:&err];
    [session addInput:input];
    layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    layer.connection.videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
    
    layer.frame = self.preView.bounds;
    [self.preView.layer insertSublayer:layer atIndex:0];
    
}
    
- (void)showVideoOnView:(UIView* _Nonnull)preView{
    self.preView = preView;
    [self setupUtils];
    [session startRunning];
}
    
- (void)stopVideo{
    [session stopRunning];
}
    
@end
