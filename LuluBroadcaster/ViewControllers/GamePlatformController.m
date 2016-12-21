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

@interface GamePlatformController (){
    NSMutableArray* veins;
}

@property (weak, nonatomic) IBOutlet UIView *panel;
@property (weak, nonatomic) IBOutlet UIButton *drawButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;

@property (weak, nonatomic) IBOutlet UIImageView *vein0;
@property (weak, nonatomic) IBOutlet UIImageView *vein1;
@property (weak, nonatomic) IBOutlet UIImageView *vein2;
@property (weak, nonatomic) IBOutlet UIImageView *vein3;
@property (weak, nonatomic) IBOutlet UIImageView *vein4;
@property (weak, nonatomic) IBOutlet UIImageView *vein5;

@end

@implementation GamePlatformController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self setupVeins];
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

#pragma mark -
#pragma mark anctions
- (IBAction)endAction:(id)sender {
     [[GameManager sharedManager] endDealer:self.scene.room];
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
        }
    } room:self.scene.room];
}

@end
