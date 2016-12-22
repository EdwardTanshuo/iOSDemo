//
//  GamePlatformController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/19/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "GamePlatformController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Card.h"
#import "CardValue.h"
#import "LiveAlertView.h"

static NSInteger secondRemain;

@interface GamePlatformController (){
    NSMutableArray* veins;
}

@property (weak, nonatomic) IBOutlet UIView         *panel;
@property (weak, nonatomic) IBOutlet UIButton       *drawButton;
@property (weak, nonatomic) IBOutlet UIButton       *endButton;

@property (weak, nonatomic) IBOutlet UIImageView    *vein0;
@property (weak, nonatomic) IBOutlet UIImageView    *vein1;
@property (weak, nonatomic) IBOutlet UIImageView    *vein2;
@property (weak, nonatomic) IBOutlet UIImageView    *vein3;
@property (weak, nonatomic) IBOutlet UIImageView    *vein4;
@property (weak, nonatomic) IBOutlet UIImageView    *vein5;

@property (weak, nonatomic) IBOutlet UILabel        *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel        *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *betLabel;

@property (strong, nonatomic) NSTimer               *timer;

@end

@implementation GamePlatformController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self setupVeins];
    [self setupTimer];
}

- (void)setupViews{
    self.panel.clipsToBounds = YES;
    self.panel.layer.cornerRadius = 16.0f;
}

- (void)setupVeins{
    veins = [[NSMutableArray alloc] init];
    [veins addObject: _vein0];
    [veins addObject: _vein1];
    [veins addObject: _vein2];
    [veins addObject: _vein3];
    [veins addObject: _vein4];
    [veins addObject: _vein5];
    
    [self genPlatform];
    [self genValue];
    [self genBet];
}

- (void)setupTimer{
    secondRemain = (NSInteger)(self.scene.durationDealerTurn / 1000.0f);
    self.timerLabel.text = [NSString stringWithFormat:@"%ld", secondRemain];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

#pragma mark -
#pragma mark timer
- (void)tick{
    secondRemain --;
    self.timerLabel.text = [NSString stringWithFormat:@"剩余时间： %ld秒", secondRemain];
    if(secondRemain <= 0){
        [self timeup];
    }
}

- (void)timeup{
    [self.timer invalidate];
    if([GameManager sharedManager].scene.status != SceneStatusDealerTurn){
        return;
    }
    [GameManager sharedManager].scene.status = SceneStatusInit;
    [[GameManager sharedManager].datasource sceneHasUpdated:[GameManager sharedManager].scene];
}

#pragma mark -
#pragma mark methods
- (void)genPlatform{
    NSInteger index = 0;
    for(id iter in self.scene.dealer_platfrom){
        if([iter isKindOfClass:[Card class]]){
            Card* card = iter;
            [veins[index] sd_setImageWithURL: [NSURL URLWithString:card.thumb]];
        }
        index ++;
    }
}

- (void)genValue{
    if(self.scene.dealer_value.busted){
        self.valueLabel.text = @"爆炸了";
    } else{
        self.valueLabel.text = [NSString stringWithFormat:@"当前战斗力总和：%ld", self.scene.dealer_value.value * 5];
    }
}

- (void)genBet{
    self.betLabel.text = [NSString stringWithFormat:@"%ld", [self.scene totalBet]];
}

#pragma mark -
#pragma mark anctions
- (IBAction)endAction:(id)sender {
    __weak GamePlatformController* wself = self;
    [[GameManager sharedManager] finishTurnWithCallback:^(NSError * _Nullable err, Scene * _Nullable scene) {
        if(err){
            [LiveAlertView popOutInController:wself error:err];
        } else if(scene){
            self.scene = scene;
            [[GameManager sharedManager].datasource sceneHasUpdated:[GameManager sharedManager].scene];
        }
        
    } room:self.scene.room];
}

- (IBAction)drawAction:(id)sender {
    __weak GamePlatformController* wself = self;
    [[GameManager sharedManager] drawCardWithCallback:^(NSError * _Nullable err, Card* _Nullable card, CardValue * _Nullable value) {
        if(err){
            [LiveAlertView popOutInController:wself error:err];
        } else if(card){
            NSMutableArray* temp = [NSMutableArray arrayWithArray:wself.scene.dealer_platfrom];
            [temp addObject: card];
            wself.scene.dealer_platfrom = temp;
            [wself genPlatform];
            
            wself.scene.dealer_value = value;
            [wself genValue];
        }
    } room:self.scene.room];
}

@end
