//
//  IndicatorController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/25/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "IndicatorController.h"
static UIViewController* indicatorVC = nil;

@interface IndicatorController ()

@end

@implementation IndicatorController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

+ (void)showIndicatorWithController: (UIViewController*)vc{
    if(indicatorVC){
        return;
    }
    IndicatorController* indicator = [[IndicatorController alloc] initWithNibName:@"IndicatorController" bundle:nil];
    [vc presentViewController:indicator animated:NO completion:nil];
    indicatorVC = indicator;
}

+ (void)hideIndicatorWithCallback: (IndicatorCallback _Nullable)cb{
    if(!indicatorVC){
        return;
    }
    [indicatorVC dismissViewControllerAnimated:NO completion:^{
        if(cb){
            cb();
        }
    }];
    indicatorVC = nil;
}
@end
