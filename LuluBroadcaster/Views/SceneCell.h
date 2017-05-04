//
//  SceneCell.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"

@interface SceneCell : UITableViewCell

@property (weak, nonatomic, nullable) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel *durationLabel;


- (void)configureWithRecord: (Record* _Nullable)record;
@end
