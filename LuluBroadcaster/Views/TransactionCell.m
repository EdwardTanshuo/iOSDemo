//
//  TransactionCell.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "TransactionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+TimeAgo.h"

@interface TransactionCell()
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@end

@implementation TransactionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatar.clipsToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.height / 2.0;
}

- (void) configureWithTransaction: (Transaction* _Nullable)transaction{
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:transaction.issuer.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.avatar.image = image;
    }];
    
    self.username.text = transaction.issuer.name;
    self.amount.text = [NSString stringWithFormat:@"%ld", transaction.quantity];
    
    self.date.text = [transaction.date timeAgo];
}

@end
