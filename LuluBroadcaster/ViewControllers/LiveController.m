//
//  LiveController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LiveController.h"
#import "LiveManager.h"
#import "StreamManager.h"
#import "GPUImage.h"
#import "GPUImageBeautifyFilter.h"
#import "YUGPUImageCVPixelBufferInput.h"
#import <NSLogger/LoggerClient.h>

@interface LiveController ()<LiveDataSourceDelegate, StreamManagerDelegate>
@property (nonatomic, strong) GPUImageView* imageView;
@end

@implementation LiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self launchLive];
    [self launchStream];
}

- (void)dealloc{
    [LiveManager sharedManager].delegate = nil;
    [StreamManager sharedManager].delegate = nil;
    [[LiveManager sharedManager] stopLive];
}

- (void)launchLive{
    [LiveManager sharedManager].delegate = self;
    [[LiveManager sharedManager] startLiveWithView:_imageView];
}

- (void)launchStream{
    [StreamManager sharedManager].delegate = self;
    [[StreamManager sharedManager] startRTMP];
}

- (void)setupViews{
    _imageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_imageView setBackgroundColorRed:0 green:0 blue:0 alpha:1.0];
    [self.view addSubview:_imageView];
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

#pragma mark -
#pragma mark LiveDataSourceDelegate
- (void) liveSession:(LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode{
    LogMessage(@"stream", 1, @"err");
}

- (void) liveSession:(LFLiveSession *)session debugInfo:(LFLiveDebug *)debugInfo{
    LogMessage(@"stream", 1, @"debug");
}

- (void) liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    LogMessage(@"stream", 1, @"change");
}

@end
