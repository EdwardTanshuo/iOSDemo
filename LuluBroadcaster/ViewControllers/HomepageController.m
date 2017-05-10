//
//  HomepageController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#define TEST_MODE

#import "HomepageController.h"
#import "CameraManager.h"
#import "GameManager.h"
#import "NavigationRouter.h"
#import "CustomerTabBarController.h"
#import "StreamCell.h"
#import "BroadcasterDatasource.h"
#import "ListRequest.h"
#import "UserSession.h"
#import "IndicatorController.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomepageController ()<CameraManagerDelegate, CustomerTabBarControllerDelegate>{
    BOOL lock;
}
@property (weak, nonatomic) IBOutlet UILabel *viewerLabel;
@property (weak, nonatomic) IBOutlet UITextField *signField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
 
@property (assign, nonatomic) CameraStatus status;
@end

@implementation HomepageController
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lock = NO;
    
    [CameraManager sharedManager].delegate = self;
    [self setupViews];
    
    ((CustomerTabBarController*)(self.navigationController.tabBarController)).camearaDelegate = self;
    
    self.navigationItem.title = @"相机(断开)";
}

- (void)viewWillAppear:(BOOL)animated{
    [self fillInfo];
}

- (void) dealloc{
    [CameraManager sharedManager].delegate = nil;
    [[CameraManager sharedManager] closeCamera];
}

#pragma mark -
#pragma mark methods
- (void)fillInfo{
    Broadcaster* bs = [UserSession new].currentBroadcaster;
    self.nameLabel.text = bs.name;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:bs.profileImageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.signField.text = bs.bio;
    self.viewerLabel.text = [@(bs.followers_count) stringValue];
}
    
- (void)setupViews{
    [self setupStatus];
    
    self.avatar.clipsToBounds = YES;
    self.avatar.contentMode = UIViewContentModeScaleAspectFit;
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.height / 2.0f;
    self.avatar.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.avatar.layer.borderWidth = 3.0f;
}

- (void)setupStatus{
    [self updateStatus: [CameraManager sharedManager]];
    [self openCamera];
}

- (void)updateStatus:(CameraManager*) manager{
    switch (manager.status) {
        case CameraStatusConnected:
            self.navigationItem.title = @"相机(连接)";
            self.status = CameraStatusConnected;
            [((CustomerTabBarController*)(self.navigationController.tabBarController)) active];
            break;
        case CameraStatusConnecting:
            self.navigationItem.title = @"相机(连接中..)";
            self.status = CameraStatusConnecting;
            [((CustomerTabBarController*)(self.navigationController.tabBarController)) processing];
            break;
        case CameraStatusDisconnected:
            self.navigationItem.title = @"相机(断开)";
            self.status = CameraStatusDisconnected;
            [((CustomerTabBarController*)(self.navigationController.tabBarController)) inactive];
            break;
        default:
            break;
    }
}


- (void)startLiveWithScene: (Scene*) scene{
    [IndicatorController hideIndicatorWithCallback:^{
       [NavigationRouter popLiveControllerFrom:self WithScene:scene];
    }];    
}

- (void)openCamera{
    [[CameraManager sharedManager] openCamera];
}

- (IBAction)logout:(id)sender {
    [NavigationRouter showLoginControllerOnWindow:((AppDelegate*)[UIApplication sharedApplication].delegate).window];
}

#pragma mark -
#pragma mark actions
- (IBAction)logoutAction:(id)sender {

}


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

#pragma mark -
#pragma mark CustomerTabBarControllerDelegate
- (void)didPressCameraButton{
    __weak HomepageController* wself = self;
    if(lock){
        return;
    }
#ifdef TEST_MODE
    if(YES){
#else
    if(self.status == CameraStatusConnected){
#endif
        lock = YES;
        UserSession* session = [[UserSession alloc] init];
        [[GameManager sharedManager] enterGameWithCallback:^(NSError * _Nullable err, Scene*  _Nullable scene) {
            lock = NO;
            
            if(err){
                [NavigationRouter showAlertInViewController:self WithTitle:@"相机未连接" WithMessage: [err.userInfo objectForKey:@"msg"]];
            }
            else{
                [IndicatorController showIndicatorWithController:wself];
                [[GameManager sharedManager] requestGiftsWithCallback:nil];
                [self startLiveWithScene:scene];
            }
        } room: session.currentBroadcaster.room];
    }
    else{
        lock = NO;
        [NavigationRouter showAlertInViewController:self WithTitle:@"相机未连接" WithMessage:@"请检查您的nano是否已经连接"];
    }
}

@end
