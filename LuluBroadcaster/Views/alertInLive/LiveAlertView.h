//
//  LiveAlertView.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveAlertView : UILabel
+ (void)popOutInController: (UIViewController* _Nonnull)controller error: (NSError*)err;
@end
