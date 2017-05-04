//
//  CustomerTabBarController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/12/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "CustomerTabBarController.h"
#import "ColorConstant.h"

@interface CustomerTabBarController (){
    UIButton* _camera;
    UIActivityIndicatorView* _indicator;
    UIImageView* _bg;
}
    
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
    self.tabBar.backgroundColor = [UIColor clearColor];
    
    for(UITabBarItem* item in self.tabBar.items){
        item.imageInsets = UIEdgeInsetsMake(4.0, 0.0, -4.0, 0.0);
        item.title = nil;
    }
    
    //背景
    _bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75.0f)];
    _bg.contentMode = UIViewContentModeScaleToFill;
    _bg.image = [UIImage imageNamed:@"tap_bg"];
    _bg.center = CGPointMake(self.tabBar.center.x, self.tabBar.bounds.size.height / 2.0 - 8.0f);
    [self.tabBar addSubview:_bg];
    
    //直播按钮
    _camera = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 73, 73)];
    [_camera setImage:[UIImage imageNamed:@"tap_camera_connected"] forState:UIControlStateNormal];
    _camera.center = CGPointMake(self.tabBar.center.x, self.tabBar.bounds.size.height / 2.0 - 16.0);
    [_camera addTarget:self action:@selector(cameraPressed:) forControlEvents:UIControlEventTouchDown];
    [self.tabBar addSubview:_camera];
    
    //指示器
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    CGPoint center = _camera.center;
    center.y -= 4.0f;
    _indicator.center = center;
    [_indicator startAnimating];
    [self.tabBar addSubview:_indicator];
    
    [self inactive];
}
    
    
- (void)cameraPressed:(UIButton*)sender{
    [_camearaDelegate didPressCameraButton];
}
    
- (void)active{
    [_camera setImage:[UIImage imageNamed:@"tap_camera_connected"] forState:UIControlStateNormal];
    [_indicator removeFromSuperview];
}
    
- (void)inactive{
    [_camera setImage:[UIImage imageNamed:@"tap_camera_unconnected"] forState:UIControlStateNormal];
    [_indicator removeFromSuperview];
}
    
- (void)processing{
    [_camera setImage:[UIImage imageNamed:@"tap_camera_loading"] forState:UIControlStateNormal];
    [self.tabBar addSubview:_indicator];
}
@end
