//
//  NavigationRouter.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "NavigationRouter.h"
#import "LiveController.h"
#import "LoginController.h"
#import "CustomerTabBarController.h"

@implementation NavigationRouter
+ (void)popLiveControllerFrom:(UIViewController*)parentController{
    LiveController* vc = [[LiveController alloc] initWithNibName:@"LiveController" bundle:nil];
    [parentController presentViewController:vc animated:YES completion:nil];
}

+ (void)showLoginControllerOnWindow: (UIWindow*)window{
    LoginController* login_vc = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    window.rootViewController = login_vc;
}

+ (void)showTabControllerOnWindow: (UIWindow*)window{
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CustomerTabBarController* tab = [sb instantiateViewControllerWithIdentifier:@"tab_main"];
    window.rootViewController = tab;
}

+ (void)showAlertInViewController: (UIViewController*)controller
                        WithTitle: (NSString*)title
                      WithMessage: (NSString*)msg{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* act0 = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:act0];
    [controller presentViewController:alert animated:YES completion:nil];
}

@end
