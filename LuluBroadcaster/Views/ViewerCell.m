//
//  ViewerCell.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "ViewerCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ViewerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.height / 2.0;
    self.avatarImageView.layer.borderColor = [[UIColor purpleColor] colorWithAlphaComponent:0.6].CGColor;
    self.avatarImageView.layer.borderWidth = 0.8f;
}

- (void) configureCell{
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.viewer.avatar] placeholderImage:[UIImage imageNamed:@"profile-placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
}
@end
