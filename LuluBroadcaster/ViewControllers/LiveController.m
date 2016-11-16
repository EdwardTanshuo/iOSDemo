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
#import <GPUImage/GPUImageFramework.h>
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
}

- (void)dealloc{
    [LiveManager sharedManager].delegate = nil;
    [[LiveManager sharedManager] stopLive];
   
}

- (void)launchLive{
    [LiveManager sharedManager].delegate = self;
    [[LiveManager sharedManager] startLiveWithView:_imageView];
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


- (void)bufferFetched:(CVPixelBufferRef)buffer{
    _debug.text = [NSString stringWithFormat:@"%d", ((char*)buffer)[0]];
}

@end
