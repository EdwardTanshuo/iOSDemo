//
//  CustomerNavigationController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/11/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "CustomerNavigationController.h"
#import "ColorConstant.h"

@interface CustomerNavigationController ()

@end

@implementation CustomerNavigationController
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // navigationbar
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"Avenir-Heavy" size:17.0], NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationBar.barTintColor = [ColorConstant mclMediumPinkColor];
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    //tabbar
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(4.0, 0.0, -4.0, 0.0);
    
    //status bar
    [self preferredStatusBarStyle];
    [self prefersStatusBarHidden];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
