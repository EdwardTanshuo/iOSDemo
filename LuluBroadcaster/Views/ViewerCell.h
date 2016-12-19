//
//  ViewerCell.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ViewerCell : UICollectionViewCell
@property (strong, nonatomic) User* viewer;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
- (void) configureCell;
@end
