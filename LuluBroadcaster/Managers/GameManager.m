//
//  GameManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/7/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "GameManager.h"
#import "Pomelo.h"
#import "PomeloProtocol.h"

@interface GameManager()<PomeloDelegate>
@property (nonatomic, strong) Pomelo* pomelo;
@end

@implementation GameManager
+ (GameManager* _Nonnull)sharedManager{
    static GameManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pomelo = [[Pomelo alloc] initWithDelegate:self];
        self.scene = [[Scene alloc] init];
        [self setupEventListener];
    }
    return self;
}

#pragma mark -
#pragma mark PomeloReuqests
- (void)connect{
    __weak GameManager* wself = self;
    [_pomelo connectToHost:GAME_IP onPort:GAME_PORT withCallback:^(Pomelo *p) {
        [wself.target didConnected];
    }];
}

- (void)entry: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate entryCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"broadcaster.entryHandler.entry" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)createGame: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate createCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.createGame" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)startBet: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate betCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.startBet" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)startGame: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate startCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.startGame" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)endDealer: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate endCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.dealerFinish" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)endGame: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate endDealerCallBack: argsData];
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.endGame" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)drawCard: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate drawCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.drawCard" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)finishTurn: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate finishTurnCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.finishTurn" andParams:@{@"roomId": room} andCallback:cb];
}

#pragma mark -
#pragma mark PomeloEvents
- (void)setupEventListener{
    __weak GameManager* wself = self;
  
    [_pomelo onRoute:@"PlayerEnterEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.target PlayerEnterEvent:data];
        });
    }];
    
    [_pomelo onRoute:@"PlayerLeaveEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.target PlayerLeaveEvent:data];
        });
    }];
    
    [_pomelo onRoute:@"NewTurnEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.target NewTurnEvent:data];
        });
    }];
}
#pragma mark -
#pragma mark PomeloDelegate
- (void)PomeloDidDisconnect:(Pomelo *)pomelo withError:(NSError *)error{
    [self.target disconnect:error];
}
@end
