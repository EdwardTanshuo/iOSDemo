//
//  CaptureManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/7/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CaptureManager : NSObject
@property (nullable, nonatomic, weak) UIView* preView;
+ (CaptureManager* _Nonnull)sharedManager;
    
- (void)showVideoOnView:(UIView* _Nonnull)preView;
@end
