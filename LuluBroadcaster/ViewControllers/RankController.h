//
//  RankController.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankController : UIViewController
@property(nonatomic, nonnull, strong) NSArray* list;

+ (void)popoutWithList:(NSArray* _Nonnull)list WithController:(UIViewController* _Nonnull)vc;
@end
