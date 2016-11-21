//
//  TransactionCell.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface TransactionCell : UITableViewCell
@property (nonatomic, strong, nullable) Transaction* transaction;
- (void) configureWithTransaction: (Transaction* _Nullable)transaction;
@end
