//
//  PlayerDrawController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//
#import "PlayerDrawController.h"
static NSInteger secondRemain;

@interface PlayerDrawController ()
@property (weak, nonatomic) IBOutlet UILabel*   timerLabel;
@property (weak, nonatomic) IBOutlet UIView *pad;
@property (strong, nonatomic) NSTimer*          timer;
@end

@implementation PlayerDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self setupTimer];
}

#pragma mark -
#pragma mark setups
- (void)setupViews{
    __weak PlayerDrawController* wself = self;
    self.pad.alpha = 0.0f;
    self.pad.clipsToBounds = YES;
    self.pad.layer.cornerRadius = 8.0f;
    [UIView animateWithDuration:0.3f animations:^{
        wself.pad.alpha = 1.0f;
    }];
}

- (void)setupTimer{
    secondRemain = 60;
    self.timerLabel.text = [NSString stringWithFormat:@"%ld", secondRemain];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

#pragma mark -
#pragma mark timer
- (void)tick{
    secondRemain --;
    self.timerLabel.text = [NSString stringWithFormat:@"%ld", secondRemain];
    if(secondRemain == 0){
        [self timeup];
    }
}

- (void)timeup{
    [self.timer invalidate];
}

@end
