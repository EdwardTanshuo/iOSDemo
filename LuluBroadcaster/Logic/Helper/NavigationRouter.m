//
//  NavigationRouter.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "NavigationRouter.h"

#import "LiveController.h"

@implementation NavigationRouter
+ (void)popLiveControllerFrom:(UIViewController*)parentController{
    LiveController* vc = [[LiveController alloc] initWithNibName:@"LiveController" bundle:nil];
    [parentController presentViewController:vc animated:YES completion:nil];
}

@end
