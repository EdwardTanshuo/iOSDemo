//
//  BettingController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "BettingController.h"

@interface BettingController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation BettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupViews{
    
}

#pragma mark -
#pragma mark actions
- (IBAction)startGame:(id)sender {
    //self.startButton.userInteractionEnabled = NO;
    [[GameManager sharedManager] startGame: self.scene.room];
}

@end
