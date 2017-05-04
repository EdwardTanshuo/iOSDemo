//
//  FollowerCell.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/10/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface FollowerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *lv;
@property (weak, nonatomic) IBOutlet UILabel *intimacy;

@property (strong, nonatomic) User* user;

- (void)configureWithUser: (User*)user;
@end
