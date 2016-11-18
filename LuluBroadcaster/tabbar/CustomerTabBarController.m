//
//  CustomerTabBarController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/12/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "CustomerTabBarController.h"
#import "ColorConstant.h"

@interface CustomerTabBarController ()
@property (strong, nonatomic) UIButton* camera;
@end

@implementation CustomerTabBarController
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [ColorConstant mclMediumPinkColor];
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    for(UITabBarItem* item in self.tabBar.items){
        item.imageInsets = UIEdgeInsetsMake(4.0, 0.0, -4.0, 0.0);
        item.title = nil;
    }
    
    _camera = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [_camera setImage:[UIImage imageNamed:@"tab_live_default"] forState:UIControlStateNormal];
    _camera.center = CGPointMake(self.tabBar.center.x, self.tabBar.bounds.size.height / 2.0 - 16.0);
    [_camera addTarget:self action:@selector(cameraPressed:) forControlEvents:UIControlEventTouchDown];
    [self.tabBar addSubview:_camera];
}


- (void)cameraPressed:(UIButton*)sender{
    [_camearaDelegate didPressCameraButton];
}

- (void)active{
    [self.camera setImage:[UIImage imageNamed:@"tab_live_default"] forState:UIControlStateNormal];
}

- (void)inactive{
    [self.camera setImage:[UIImage imageNamed:@"tab_camera_inactive"] forState:UIControlStateNormal];
}

@end
