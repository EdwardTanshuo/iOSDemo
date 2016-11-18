//
//  StreamCell.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/17/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "StreamCell.h"


@implementation StreamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.avatar.clipsToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.height / 2.0;
    
    self.live_tag.clipsToBounds = YES;
    self.live_tag.layer.cornerRadius = self.live_tag.bounds.size.height / 2.0;
    
    self.recordIcon.clipsToBounds = YES;
    self.recordIcon.layer.cornerRadius = self.recordIcon.bounds.size.height / 2.0;
    
    self.preview.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

- (void)configWithBroadcaster:(Broadcaster *)broadcaster{
    self.name.text = broadcaster.name;
    self.viewer_count.text = [NSString stringWithFormat:@"%ld人观看", broadcaster.viewers_count];
   
    [self.avatar sd_setImageWithURL: [NSURL URLWithString:broadcaster.profileImageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.avatar.image = image;
    }];
    [self.preview sd_setImageWithURL: [NSURL URLWithString:broadcaster.profileImageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.avatar.image = image;
    }];
    
}
@end
