//
//  HistoryCell.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//
#import "NSDate+TimeAgo.h"
#import "HistoryCell.h"
@interface HistoryCell()
@property (weak, nonatomic) IBOutlet UILabel *time;
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
    [formatter setDateFormat:@"hh:mm"];
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSString *start_str = [formatter stringFromDate:history.start];
    NSString *end_str = [formatter stringFromDate:history.end];
    NSString* final = [NSString stringWithFormat:@"%@ -- %@", start_str, end_str];
    self.time.text = final;
    
    self.date.text = [history.start timeAgo];
    
    self.amount.text = [NSString stringWithFormat:@"+%ld", history.value];
}

@end
