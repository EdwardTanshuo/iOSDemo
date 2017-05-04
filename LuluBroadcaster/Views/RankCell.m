//
//  RankCell.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "RankCell.h"

@implementation RankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)configWithData:(NSDictionary*)data WithIndex:(NSInteger)index{
    self.nameLabel.text = data[@"name"];
    self.rankLabel.text = [@(index + 1) stringValue];
    self.winningLabel.text = [data[@"benifit"] stringValue];
}

@end
