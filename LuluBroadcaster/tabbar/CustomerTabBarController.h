//
//  CustomerTabBarController.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/12/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomerTabBarControllerDelegate
- (void)didPressCameraButton;
@end

@interface CustomerTabBarController : UITabBarController
@property (weak, nonatomic, nullable) id<CustomerTabBarControllerDelegate> camearaDelegate;
@end
