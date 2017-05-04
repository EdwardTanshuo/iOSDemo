//
//  RankCell.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *winningLabel;

- (void)configWithData:(NSDictionary*)data WithIndex:(NSInteger)index;
@end
