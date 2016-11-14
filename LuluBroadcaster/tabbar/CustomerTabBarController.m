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
    
    
    for(UITabBarItem* item in self.tabBar.items){
        item.imageInsets = UIEdgeInsetsMake(4.0, 0.0, -4.0, 0.0);
        item.title = nil;
    }
    
    UIImageView* panel = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    panel.image = [UIImage imageNamed:@"tab_camera_default"];
    panel.center = CGPointMake(self.tabBar.center.x, self.tabBar.bounds.size.height / 2.0 - 16.0);
    
    [self.tabBar addSubview:panel];
}


@end
