//
//  DanmuCell.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "DanmuCell.h"
#import "ColorConstant.h"

@interface DanmuCell()
@property (weak, nonatomic) IBOutlet UILabel *content;
@end

@implementation DanmuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.content.frame = CGRectMake(0,0,self.content.bounds.size.width,35.0);
    self.content.clipsToBounds = YES;
    self.content.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    self.content.numberOfLines = 100;
    
    self.translatesAutoresizingMaskIntoConstraints = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) configureWithDanmu: (Danmu*)danmu{
    self.danmu = danmu;
    NSString* name = danmu.user;
    NSString* content = danmu.word;
    
    NSMutableAttributedString* as0 = nil;
    switch (danmu.type) {
        case NormalDanmuType:
            as0 = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"[弹幕] %@: ", name] attributes:@{NSForegroundColorAttributeName: [ColorConstant mclMediumPinkColor], NSFontAttributeName: [UIFont systemFontOfSize: 12.0f]}];
            break;
        case GiftDanmuType:
            as0 = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"[礼物] %@: ", name] attributes:@{NSForegroundColorAttributeName: [ColorConstant mclMediumBlue], NSFontAttributeName: [UIFont systemFontOfSize: 12.0f]}];
            break;
        default:
            break;
    }
    
    NSMutableAttributedString* as1 = [[NSMutableAttributedString alloc] initWithString: content attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 12.0f]}];
    NSMutableAttributedString* as_final = [[NSMutableAttributedString alloc] init];
    [as_final appendAttributedString: as0];
    [as_final appendAttributedString: as1];
    self.content.attributedText = as_final;
    self.content.numberOfLines = 99;
    [self height:danmu];
    
}

- (CGFloat) height: (Danmu*)danmu{
    CGSize constraint = CGSizeMake(100.0, 20000.0);
    CGRect rect = [[NSString stringWithFormat:@"%@:  %@", danmu.user, danmu.word] boundingRectWithSize: constraint options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 12.0f]} context: nil];
    self.content.frame = rect;
    return rect.size.height + 20.0f;
}

@end
