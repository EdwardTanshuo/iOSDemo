//
//  HistoryCell.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "HistoryCell.h"
@interface HistoryCell()
@property (weak, nonatomic, nullable) IBOutlet UILabel *date;
@property (weak, nonatomic, nullable) IBOutlet UILabel *amount;
@end

@implementation HistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) configureWithBroad: (Broad*)history{
    self.history = history;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd hh:mm"];
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSString *start_str = [formatter stringFromDate:history.start];
    NSString *end_str = [formatter stringFromDate:history.end];
    NSString* final = [NSString stringWithFormat:@"%@ 至 %@", start_str, end_str];
    self.date.text = final;
    
    self.amount.text = [NSString stringWithFormat:@"%ld", history.value];
}

@end
