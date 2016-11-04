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
@property (nonatomic, strong) UILabel* debug;
@property (nonatomic, strong) UILabel* error;
@end

@implementation LiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self launchLive];
    [self launchStream];
    LogMessage(@"stream", 1, @"live started");
}

- (void)dealloc{
    [LiveManager sharedManager].delegate = nil;
    [StreamManager sharedManager].delegate = nil;
    [[LiveManager sharedManager] stopLive];
    [[StreamManager sharedManager] stopRTMP];
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
    
    UILabel* debug = [[UILabel alloc] initWithFrame:self.view.bounds];
    debug.numberOfLines = 2;
    [self.view addSubview:debug];
    debug.textColor = [UIColor whiteColor];
    _debug = debug;
    
    CGRect rect = self.view.bounds;
    rect.origin.y += 40;
    UILabel* error = [[UILabel alloc] initWithFrame:rect];
    error.numberOfLines = 2;
    [self.view addSubview:error];
    error.textColor = [UIColor redColor];
    _error = error;
}

#pragma mark -
#pragma mark LiveDataSourceDelegate

- (void)recieveStichedFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
    
}

- (void)recieveOnRawFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
    
  
}

- (void)recieveError:(NSError *)error{
     self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark -
#pragma mark StreamManagerDelegate
- (void)ready{
    _debug.text = @"ready";
}
- (void)started{
    _debug.text = @"started";
}
- (void)failed{
    _debug.text = @"failed";
}
- (void)pending{
    _debug.text = @"pending";
}
- (void)stop{
    _debug.text = @"stop";
}

- (void)debug:(LFLiveDebug *)debugInfo{
    
}

- (void)error:(LFLiveSocketErrorCode)code{
   _error.text = [NSString stringWithFormat:@"%d", code];
}

@end
