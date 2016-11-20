//
//  SettingViewController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "SettingViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ColorConstant.h"
#import "UserSession.h"
#import "NavigationRouter.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UIView *avata_pad;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@end

@implementation SettingViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self reloadInfo];
}

- (void)setupView{
    self.avata_pad.clipsToBounds = YES;
    self.avata_pad.layer.cornerRadius = self.avata_pad.bounds.size.height / 2.0;

    self.avatar.clipsToBounds = YES;
    self.avatar.layer.borderColor = [[[ColorConstant mclMediumPinkColor] colorWithAlphaComponent:0.5] CGColor];
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.height / 2.0;
    self.avatar.layer.borderWidth = 1.0;
    
}

- (void)reloadInfo{
    UserSession* session = [[UserSession alloc] init];
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:session.currentBroadcaster.profileImageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.avatar.image = image;
    }];
    
    self.name.text = session.currentBroadcaster.name;
}

#pragma mark -
#pragma mark actions

@end
