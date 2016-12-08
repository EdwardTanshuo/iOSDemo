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
        [self setupEventListener];
    }
    return self;
}

#pragma mark -
#pragma mark PomeloReuqests
- (void)entry: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate entryCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"broadcaster.entryHandler.entry" andParams:@{@"room": room} andCallback:cb];
}

- (void)createGame: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate createCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"broadcaster.broadcasterHandler.createGame" andParams:@{@"room": room} andCallback:cb];
}

- (void)startGame: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate startCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"broadcaster.broadcasterHandler.startGame" andParams:@{@"room": room} andCallback:cb];
}

- (void)endGame: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate endCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"broadcaster.broadcasterHandler.endGame" andParams:@{@"room": room} andCallback:cb];
}

- (void)drawCard: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate drawCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"broadcaster.broadcasterHandler.drawCard" andParams:@{@"room": room} andCallback:cb];
}

- (void)finishTurn: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate finishTurnCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"broadcaster.broadcasterHandler.finishTurn" andParams:@{@"room": room} andCallback:cb];
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

@end
