//
//  FollowerCell.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/10/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "FollowerCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation FollowerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.avatar.clipsToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.height / 2.0f;
    self.avatar.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.avatar.layer.borderWidth = 2.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithUser: (User* _Nullable)user{
    self.user = user;
    
    self.name.text = user.name;
    self.lv.text = [NSString stringWithFormat:@"用户等级：%@", user.level];
    self.intimacy.text = user.intimacy;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}
@end
