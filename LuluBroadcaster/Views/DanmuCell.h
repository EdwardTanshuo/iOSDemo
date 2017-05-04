//
//  DanmuCell.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Danmu.h"

@interface DanmuCell : UITableViewCell
@property (strong, nonatomic, nullable) Danmu*  danmu;

- (void) configureWithDanmu: (Danmu* _Nonnull)danmu;
- (CGFloat) height: (Danmu* _Nonnull)danmu;
@end
