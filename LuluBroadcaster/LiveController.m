//
//  LiveController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LiveController.h"
#import "LiveManager.h"
#import <GPUImage/GPUImage.h>
#import "GPUImageBeautifyFilter.h"
#import "YUGPUImageCVPixelBufferInput.h"

@interface LiveController ()<LiveDataSourceDelegate>

@end

@implementation LiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self launchLive];
    GPUImageView *imageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [imageView setBackgroundColorRed:0 green:0 blue:0 alpha:1.0];
    [self.view addSubview:imageView];
    GPUImageBeautifyFilter *filter = [[GPUImageBeautifyFilter alloc] init];
    [filter addTarget:imageView];
    [[LiveManager sharedManager].pixelBufferInput addTarget:filter];

}

- (void)launchLive{
    [LiveManager sharedManager].delegate = self;
    [[LiveManager sharedManager] startLive];
}

#pragma mark -
#pragma mark LiveDataSourceDelegate

- (void)recieveStichedFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
     //assert(false);
}

- (void)recieveOnRawFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
    
  
}

- (void)recieveError:(NSError *)error{
     self.view.backgroundColor = [UIColor blackColor];
}

@end
