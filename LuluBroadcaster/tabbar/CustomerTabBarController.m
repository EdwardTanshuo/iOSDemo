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

@end

@implementation CustomerTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [ColorConstant mclMediumPinkColor];
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    self.tabBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    for(UITabBarItem* item in self.tabBar.items){
        item.imageInsets = UIEdgeInsetsMake(4.0, 0.0, -4.0, 0.0);
        item.title = nil;
    }
    
    UIButton* camera = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [camera setImage:[UIImage imageNamed:@"tab_camera_default"] forState:UIControlStateNormal];
    camera.center = CGPointMake(self.tabBar.center.x, self.tabBar.bounds.size.height / 2.0 - 16.0);
    [camera addTarget:self action:@selector(cameraPressed:) forControlEvents:UIControlEventTouchDown];
    [self.tabBar addSubview:camera];
}


- (void)cameraPressed:(UIButton*)sender{
    [_camearaDelegate didPressCameraButton];
}

@end
