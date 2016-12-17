//
//  NavigationRouter.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scene.h"

@interface NavigationRouter : NSObject
+ (void)popLiveControllerFrom:(UIViewController*)parentController WithScene:(Scene*)scene;
+ (void)showLoginControllerOnWindow: (UIWindow*)window;
+ (void)showTabControllerOnWindow: (UIWindow*)window;
+ (void)showAlertInViewController: (UIViewController*)controller WithTitle: (NSString*)title WithMessage: (NSString*)msg;
+ (void)showCleanActionSheetInViewController: (UIViewController*)controller;
+ (void)showHistoryViewController: (UIViewController*)controller;
+ (void)showLogoutActionSheetInViewController: (UIViewController*)controller;
@end
