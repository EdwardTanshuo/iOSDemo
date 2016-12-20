//
//  GamePlatformController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/19/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "GamePlatformController.h"

@interface GamePlatformController ()
@property (weak, nonatomic) IBOutlet UIView *panel;

@end

@implementation GamePlatformController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupViews{
    self.panel.clipsToBounds = YES;
    self.panel.layer.cornerRadius = 16.0f;
}

@end
