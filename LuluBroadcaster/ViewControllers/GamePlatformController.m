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
    NSMutableArray* veinLs;
    
    BOOL lock;
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

@property (weak, nonatomic) IBOutlet UILabel *veinL0;
@property (weak, nonatomic) IBOutlet UILabel *veinL1;
@property (weak, nonatomic) IBOutlet UILabel *veinL2;
@property (weak, nonatomic) IBOutlet UILabel *veinL3;
@property (weak, nonatomic) IBOutlet UILabel *veinL4;
@property (weak, nonatomic) IBOutlet UILabel *veinL5;



@property (weak, nonatomic) IBOutlet UILabel        *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel        *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel        *betLabel;

@property (strong, nonatomic) NSTimer               *timer;

@end

@implementation GamePlatformController

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
    [self setupVeins];
    [self setupTimer];
    
    lock = NO;
}

- (void)setupViews{
    self.panel.clipsToBounds = YES;
    self.panel.layer.cornerRadius = 16.0f;
    self.drawButton.userInteractionEnabled = YES;
}

- (void)setupVeins{
    veins = [[NSMutableArray alloc] init];
    [veins addObject: _vein0];
    [veins addObject: _vein1];
    [veins addObject: _vein2];
    [veins addObject: _vein3];
    [veins addObject: _vein4];
    [veins addObject: _vein5];
    
    veinLs = [[NSMutableArray alloc] init];
    [veinLs addObject: _veinL0];
    [veinLs addObject: _veinL1];
    [veinLs addObject: _veinL2];
    [veinLs addObject: _veinL3];
    [veinLs addObject: _veinL4];
    [veinLs addObject: _veinL5];
    
    [self genPlatform];
    [self genValue];
    [self genBet];
}

- (void)setupTimer{
    self.timerLabel.textColor = [UIColor whiteColor];
    secondRemain = (NSInteger)(self.scene.durationDealerTurn / 1000.0f);
    self.timerLabel.text = [NSString stringWithFormat:@"%ld", secondRemain];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

#pragma mark -
#pragma mark timer
- (void)tick{
    secondRemain --;
    if(secondRemain == 5){
        self.drawButton.userInteractionEnabled = NO;
        self.timerLabel.textColor = [UIColor redColor];
        [self loopDrawWhenLessThan85];
    }
    
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

- (void)cleanPlatform{
    for(UILabel* iter in veinLs){
        iter.text = @"";
    }
    
    for(UIImageView* iter in veins){
        iter.image = [UIImage new];
    }
}

- (void)genPlatform{
    [self cleanPlatform];
    NSInteger index = 0;
    for(id iter in self.scene.dealer_platfrom){
        if([iter isKindOfClass:[Card class]]){
            Card* card = iter;
            NSInteger value = card.value;
            if(value == 14){
                value = 1;
            }
            value --;
            ((UIImageView*)(veins[index])).image = [UIImage imageNamed:[NSString stringWithFormat:@"z%ld", (long)value]];
            if(card.value == 14){
                ((UILabel*)(veinLs[index])).text = [NSString stringWithFormat:@"5/55"];
               
            } else if(card.value > 10){
                ((UILabel*)(veinLs[index])).text = [NSString stringWithFormat:@"50"];
            } else{
                ((UILabel*)(veinLs[index])).text = [NSString stringWithFormat:@"%ld", (long)card.value * 5];
            }
        }
        index ++;
    }
}

- (void)genValue{
    if(self.scene.dealer_value.busted){
        self.valueLabel.text = @"爆炸了";
        self.drawButton.userInteractionEnabled = NO;
    } else{
        self.valueLabel.text = [NSString stringWithFormat:@"当前战斗力总和：%ld", self.scene.dealer_value.value * 5];
        if(self.scene.dealer_value.value * 5 > 85){
            self.drawButton.userInteractionEnabled = NO;
        }
    }
}

- (void)genBet{
    self.betLabel.text = [NSString stringWithFormat:@"%ld", [self.scene totalBet]];
}

- (void)loopDrawWhenLessThan85{
    __weak GamePlatformController* wself = self;
    if(lock){
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.5*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [wself loopDrawWhenLessThan85];
        });
        
    }
    
    if(self.scene.dealer_value.value * 5 > 85){
        [wself genValue];
        return;
    }
    
    lock = YES;
    self.valueLabel.text = @"自动抽卡...";
    [[GameManager sharedManager] drawCardWithCallback:^(NSError * _Nullable err, Card* _Nullable card, CardValue * _Nullable value) {
        lock = NO;
        if(err){
            [LiveAlertView popOutInController:wself error:err];
            [wself genValue];
        } else if(card){
            NSMutableArray* temp = [NSMutableArray arrayWithArray:wself.scene.dealer_platfrom];
            [temp addObject: card];
            wself.scene.dealer_platfrom = temp;
            [wself genPlatform];
            wself.scene.dealer_value = value;
            [wself performSelectorOnMainThread:@selector(loopDrawWhenLessThan85) withObject:nil waitUntilDone:NO];
        }
    } room:self.scene.room];
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
            [[GameManager sharedManager].datasource sceneHasUpdated:scene];
        }
        
    } room:self.scene.room];
}

- (IBAction)drawAction:(id)sender {
    __weak GamePlatformController* wself = self;
    if(lock){
        return;
    }
    lock = YES;
    [[GameManager sharedManager] drawCardWithCallback:^(NSError * _Nullable err, Card* _Nullable card, CardValue * _Nullable value) {
        lock = NO;
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
