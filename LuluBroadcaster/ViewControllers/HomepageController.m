//
//  HomepageController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "HomepageController.h"
#import "CameraManager.h"
#import "NavigationRouter.h"

@interface HomepageController ()<CameraManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@end

@implementation HomepageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CameraManager sharedManager].delegate = self;
    [self setupViews];
    
    self.navigationItem.title = @"直播";
}

- (void) dealloc{
    [CameraManager sharedManager].delegate = nil;
    [[CameraManager sharedManager] closeCamera];
}

#pragma mark -
#pragma mark methods
- (void)setupViews{
    [self setupStatus];
    [self setupButtons];
}

- (void)setupButtons{
    [self.startButton addTarget:self action:@selector(startLive) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupStatus{
    [self updateStatus: [CameraManager sharedManager]];
    [self openCamera];
}

- (void)updateStatus:(CameraManager*) manager{
    switch (manager.status) {
        case CameraStatusConnected:
            [self.startButton setTitle:@"开始测试" forState:UIControlStateNormal];
            self.startButton.userInteractionEnabled = YES;
            break;
        case CameraStatusConnecting:
            [self.startButton setTitle:@"连接中" forState:UIControlStateNormal];
            self.startButton.userInteractionEnabled = NO;
            break;
        case CameraStatusDisconnected:
            [self.startButton setTitle:@"没有找到相机" forState:UIControlStateNormal];
            self.startButton.userInteractionEnabled = NO;
            break;
        default:
            break;
    }
}

- (void)startLive{
    [NavigationRouter popLiveControllerFrom:self];
}

- (void)openCamera{
    [[CameraManager sharedManager] openCamera];
}

#pragma mark -
#pragma mark actions

#pragma mark -
#pragma mark CameraManagerDelegate

- (void)cameraDidConnect:(CameraManager *)manager{
    [self updateStatus: manager];
}

- (void)cameraConnectFail:(CameraManager *)manager{
    [self updateStatus: manager];
}

- (void)cameraIsConnecting:(CameraManager *)manager{
    [self updateStatus: manager];
}

- (void)cameraDidDisconnect:(CameraManager *)manager{
    [self updateStatus: manager];
}


@end
