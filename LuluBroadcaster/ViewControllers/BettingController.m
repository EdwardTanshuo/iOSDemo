//
//  BettingController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "BettingController.h"

static NSInteger secondRemain;

@interface BettingController ()
@property (weak, nonatomic) IBOutlet UIView     *pad;
@property (weak, nonatomic) IBOutlet UILabel    *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton   *startButton;

@property (weak, nonatomic) IBOutlet UILabel *playerNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *magicStoneNumLabel;


@property (strong, nonatomic) NSTimer*          timer;
@end

@implementation BettingController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self setupTimer];
    [self setupNotification];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark setups
- (void)setupViews{
    __weak BettingController* wself = self;
    self.pad.alpha = 0.0f;
    self.pad.clipsToBounds = YES;
    self.pad.layer.cornerRadius = 8.0f;
    [UIView animateWithDuration:0.3f animations:^{
        wself.pad.alpha = 1.0f;
    }];
}

- (void)setupTimer{
    secondRemain = (NSInteger)(self.scene.durationBet / 1000.0f);
    self.timerLabel.text = [NSString stringWithFormat:@"%ld", secondRemain];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void)setupNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateInfo:) name:@"PlayerBetEvent" object:nil];
}

#pragma mark -
#pragma mark timer
- (void)tick{
    secondRemain --;
    self.timerLabel.text = [NSString stringWithFormat:@"%ld", secondRemain];
    if(secondRemain <= 0){
        [self timeup];
    }
}

- (void)timeup{
    [self.timer invalidate];
    if([GameManager sharedManager].scene.status != SceneStatusBetting){
        return;
    }
    [GameManager sharedManager].scene.status = SceneStatusInit;
    [[GameManager sharedManager].datasource sceneHasUpdated:[GameManager sharedManager].scene];
}

#pragma mark -
#pragma mark actions

- (void)updateInfo: (NSNotification*)notice{
    id data = notice.object;
    self.playerNumLabel.text = [NSString stringWithFormat:@"%ld", [data[@"body"][@"totalBet"] integerValue]];
    self.magicStoneNumLabel.text = [NSString stringWithFormat:@"%ld", [data[@"body"][@"totalPlayers"] integerValue]];
}

- (IBAction)startGame:(id)sender {
    //self.startButton.userInteractionEnabled = NO;
    [self.timer invalidate];
    [[GameManager sharedManager] startGame: self.scene.room];
}

@end
