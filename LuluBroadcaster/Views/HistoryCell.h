//
//  HistoryCell.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Broad.h"

@interface HistoryCell : UITableViewCell
@property (nonatomic, strong, nullable) Broad* history;
- (void) configureWithBroad: (Broad* _Nullable)history;
@end
