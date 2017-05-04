//
//  SceneCell.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "SceneCell.h"

@implementation SceneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithRecord: (Record* _Nullable)record{
    self.dateLabel.text = record.day;
    self.timeLabel.text = [NSString stringWithFormat:@"%@~%@", record.start_time, record.finish_time];
    NSString* durationStr = @"";
    if(record.duration < 60){
        if(record.duration == 0){
            durationStr = [NSString stringWithFormat:@"小于1分钟"];
        } else{
            durationStr = [NSString stringWithFormat:@"%ld分钟", record.duration];
        }
    } else{
        NSInteger h = record.duration / 60;
        NSInteger m = (record.duration % 60);
        durationStr = [NSString stringWithFormat:@"%ld小时%ld分钟", h, m];
    }
    self.durationLabel.text = durationStr;
}

@end
