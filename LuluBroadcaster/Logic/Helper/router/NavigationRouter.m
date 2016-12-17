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
#import "HistoryViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation NavigationRouter
+ (void)popLiveControllerFrom:(UIViewController*)parentController WithScene:(Scene*)scene{
    LiveController* vc = [[LiveController alloc] initWithNibName:@"LiveController" bundle:nil];
    vc.scene = scene;
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

+ (void)showCleanActionSheetInViewController: (UIViewController*)controller{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"清理缓存？" message:@"请确认是否需要清理本地数据" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* act0 = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SDImageCache *imageCache = [SDImageCache sharedImageCache];
        [imageCache clearMemory];
        [imageCache clearDisk];
    }];
    
    UIAlertAction* act1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:act0];
    [alert addAction:act1];
    [controller presentViewController:alert animated:YES completion:nil];
}

+ (void)showLogoutActionSheetInViewController: (UIViewController*)controller{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确认登出？" message:@"登出将结束您的直播单元" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* act0 = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGOUT" object:nil];
    }];
    
    UIAlertAction* act1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:act0];
    [alert addAction:act1];
    [controller presentViewController:alert animated:YES completion:nil];
}

+ (void)showHistoryViewController: (UIViewController*)controller{
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HistoryViewController* history = [sb instantiateViewControllerWithIdentifier:@"history"];
    [controller.navigationController pushViewController:history animated:YES];
}

@end
