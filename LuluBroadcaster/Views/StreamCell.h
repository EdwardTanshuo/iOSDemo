//
//  StreamCell.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/17/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Broadcaster.h"

@interface StreamCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *viewer_count;
@property (strong, nonatomic) Broadcaster *broadcaster;

- (void)configWithBroadcaster: (Broadcaster*)broadcaster;
@end
