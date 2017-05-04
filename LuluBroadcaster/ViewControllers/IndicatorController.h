//
//  IndicatorController.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/25/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^_Nullable IndicatorCallback)();

@interface IndicatorController : UIViewController
+ (void)showIndicatorWithController: (UIViewController* _Nonnull)vc;
+ (void)hideIndicatorWithCallback: (IndicatorCallback _Nullable)cb;
@end
