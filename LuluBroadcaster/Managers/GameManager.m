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

@interface GameManager()<PomeloDelegate, UserDatasourceDelegate>{
    NSArray<Gift*>* gifts;
}
@property (nonatomic, strong) Pomelo*           pomelo;
@property (nonatomic, strong) NSArray<User*>*   palyers;
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
        gifts = @[];
        self.pomelo = [[Pomelo alloc] initWithDelegate:self];
        self.scene = [[Scene alloc] init];
        self.userDatasource = [UserDataSource new];
        self.userDatasource.delegate = self;
        [self setupEventListener];
    }
    return self;
}

- (NSArray<Gift*>* _Nonnull)giftList{
    return gifts;
}


#pragma mark -
#pragma mark connection
- (void)connectGatewayWithCallback: (GameManagerCallback)callback{
    //__weak GameManager* wself = self;
    [_pomelo connectToHost:GAME_IP onPort:GAME_PORT withCallback:^(Pomelo *p) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(p);
        });
    }];
}

- (void)connectWithIP:(NSString* _Nonnull)url WithPort:(NSInteger)port{
    __weak GameManager* wself = self;
    [_pomelo connectToHost:url onPort:port withCallback:^(Pomelo *p) {
        [wself.target didConnected];
    }];
}

- (void)connectWithIP:(NSString* _Nonnull)url WithPort:(NSInteger)port WithCallback: (GameManagerCallback)callback{
    [_pomelo connectToHost:url onPort:port withCallback:^(Pomelo *p) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(p);
        });
    }];
}

#pragma mark -
#pragma mark PomeloReuqests
- (void)queryServerInfoWithRoom:(NSString* _Nonnull)room WithCallback:(ServerInfoCallback)callback{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        NSLog(@"%@", argsData);
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.pomelo disconnectWithCallback:^(id cb) {
                callback(nil, GAME_IP, [[argsData objectForKey:@"port"] integerValue]);
            }];
        });
    };
    [_pomelo requestWithRoute:@"gate_sio.gateHandler.queryBroadcaster" andParams:@{@"room": room} andCallback:cb];
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

- (void)entryWithCallback: (GameManagerCallback)callback room: (NSString* _Nonnull)room{
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(argsData);
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

- (void)createGameWithCallback: (GameManagerCallback)callback room: (NSString* _Nonnull)room{
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(argsData);
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.createGame" andParams:@{@"roomId": room} andCallback:cb];
}
- (void)requestGiftsWithCallback:(GiftsCallback)callback{
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            id list = argsData[@"result"][@"result"][@"items"];
            if(list && [list isKindOfClass:[NSArray class]]){
                NSMutableArray* array = [NSMutableArray new];
                for(id iter in list){
                    [array addObject:[Gift giftWithJSON:iter]];
                }
                gifts = array;
                if(callback){
                    callback(nil, array);
                }
                return;
            }
            if(callback){
                callback(nil, @[]);
            }
            return;
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.listGift" andParams:@{} andCallback:cb];
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
            [wself.pomelo disconnect];
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
    [_pomelo requestWithRoute:@"scene.sceneHandler.dealerDrawCard" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)drawCardWithCallback: (GameManagerDrawCardCallback)callback room: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if([wself makeCode:argsData] == 200){
                Card* card = [wself makeCard:argsData];
                CardValue* value = [wself makeCardValue:argsData];
                callback(nil, card, value);
            }
            else{
                NSError* err = [wself makeError:argsData];
                callback(err, nil, nil);
            }
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.dealerDrawCard" andParams:@{@"roomId": room} andCallback:cb];
}


- (void)finishTurn: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.delegate finishTurnCallBack:argsData];
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.dealerFinish" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)finishTurnWithCallback: (GameManagerResultCallback)callback room: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    PomeloCallback cb = ^(id argsData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[wself.delegate finishTurnCallBack:argsData];
            if([wself makeCode:argsData] == 200){
                Scene* scene = [wself makeScene:argsData];
                callback(nil, scene);
            }
            else{
                NSError* err = [wself makeError:argsData];
                callback(err, nil);
            }
        });
    };
    [_pomelo requestWithRoute:@"scene.sceneHandler.dealerFinish" andParams:@{@"roomId": room} andCallback:cb];
}

- (void)enterGameWithCallback: (GameManagerResultCallback)callback room: (NSString* _Nonnull)room{
    __weak GameManager* wself = self;
    [wself connectGatewayWithCallback:^(id  _Nullable argsData) {
        [wself queryServerInfoWithRoom:room WithCallback:^(NSError * _Nullable err, NSString * _Nullable url, NSInteger port) {
            [wself connectWithIP:url WithPort:port WithCallback:^(id  _Nullable argsData) {
                [wself entryWithCallback:^(id  _Nullable argsData) {
                    if([self makeCode:argsData] == 200){
                        [wself createGameWithCallback:^(id  _Nullable argsData) {
                            if([[argsData objectForKey:@"code"] integerValue] == 200){
                                Scene* scene = [wself makeScene:argsData];
                                callback(nil, scene);
                            } else{
                                NSError* error = [self makeError: argsData];
                                callback(error, nil);
                            }
                        } room: room];
                    } else{
                        NSError* error = [self makeError: argsData];
                        callback(error, nil);
                    }
                } room: room];
            }];
        }];

    }];
}

- (void)sendFaceCoordinate: (NSDictionary* _Nonnull)params{
    [_pomelo notifyWithRoute:@"scene.sceneHandler.updateCoor" andParams:@{@"params": params}];
}

- (NSError* _Nullable) makeError: (id _Nullable)data{
    id errObj = [data objectForKey:@"error"];
    if(errObj && [errObj isKindOfClass: [NSString class]]){
        NSError* err = [NSError errorWithDomain: @"com.lulu.bc"
                                           code: [[data objectForKey:@"code"] integerValue]
                                       userInfo: @{@"msg": errObj}];
        return err;
    }
    else{
        return nil;
    }
}

- (Scene* _Nullable) makeScene: (id _Nullable)data{
    __weak GameManager* wself = self;
    id resultObj = [data objectForKey:@"result"];
    if(resultObj && [resultObj isKindOfClass: [NSDictionary class]]){
        Scene* scene = [Scene sceneWithJSON:resultObj];
        dispatch_async(dispatch_get_main_queue(), ^{
            //[wself.datasource sceneHasUpdated:scene];
        });
        wself.scene = scene;
        return scene;
    }
    else{
        return nil;
    }
}

- (User* _Nullable) makeUser: (id _Nullable)data{
    id resultObj = [data objectForKey:@"result"];
    if(resultObj && [resultObj isKindOfClass: [NSDictionary class]]){
        User* user = [User userWithJSON:resultObj];
        return user;
    }
    else{
        return nil;
    }
}

- (Card* _Nullable) makeCard: (id _Nullable)data{
    id resultObj = [[data objectForKey:@"result"] objectForKey:@"newCard"];
    if(resultObj && [resultObj isKindOfClass: [NSDictionary class]]){
        Card* card = [Card cardWithJSON:resultObj];
        return card;
    }
    else{
        return nil;
    }
}

- (CardValue* _Nullable) makeCardValue: (id _Nullable)data{
    id resultObj = [[data objectForKey:@"result"] objectForKey:@"newValue"];
    if(resultObj && [resultObj isKindOfClass: [NSDictionary class]]){
        CardValue* value = [CardValue valueWithJSON: resultObj];
        return value;
    }
    else{
        return nil;
    }
}


- (Scene* _Nullable) updateScene: (id _Nullable)data{
    __weak GameManager* wself = self;
    id resultObj = [data objectForKey:@"body"];
    if(resultObj && [resultObj isKindOfClass: [NSDictionary class]]){
        Scene* scene = [Scene sceneWithJSON:resultObj];
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.datasource sceneHasUpdated:scene];
        });
        wself.scene = scene;
        return scene;
    }
    else{
        return nil;
    }
}

- (User* _Nullable) updateUser: (id _Nullable)data{
    id resultObj = [data objectForKey:@"body"];
    if(resultObj && [resultObj isKindOfClass: [NSDictionary class]]){
        User* user = [User userWithJSON:resultObj];
        return user;
    }
    else{
        return nil;
    }
}

- (NSInteger)makeCode: (id _Nullable)data{
    return [[data objectForKey:@"code"] integerValue];
}


- (NSUInteger)numberOfDiamond{
    NSUInteger sum = 0;
    
    if(!self.scene.player_bets || ![self.scene.player_bets isKindOfClass: [NSDictionary class]]){
        return sum;
    }else{
        for(NSString* key in self.scene.player_bets.allKeys){
            id item = [self.scene.player_bets objectForKey:key];
            if([item isKindOfClass:[NSNumber class]]){
                sum += [item integerValue];
            }
        }
    }
    return sum;
}

#pragma mark -
#pragma mark PomeloEvents
- (void)setupEventListener{
    __weak GameManager* wself = self;
    
    [_pomelo onRoute:@"PlayerEnterEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            User* user = [wself updateUser:data];
            if(!user){
                return;
            }
            [wself.userDatasource addUser:user];
            [wself.target PlayerEnterEvent:user];
        });
    }];
    
    [_pomelo onRoute:@"PlayerLeaveEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            User* user = [wself updateUser:data];
            if(!user){
                return;
            }
            [wself.userDatasource removeUser:user];
            [wself.target PlayerLeaveEvent:user];
        });
    }];
    
    [_pomelo onRoute:@"EndPlayerEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            Scene* scene = [wself updateScene:data];
            [wself.target NewTurnEvent:scene];
        });
    }];
    
    [_pomelo onRoute:@"BetStartEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            Scene* scene = [wself updateScene:data];
            [wself.target BetStartEvent:scene];
        });
    }];
    
    [_pomelo onRoute:@"GameStartEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            Scene* scene = [wself updateScene:data];
            [wself.target GameStartEvent:scene];
        });
    }];
    
    [_pomelo onRoute:@"DealerLeaveEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            Scene* scene = [wself updateScene:data];
            [wself.target GameEndEvent:scene];
        });
    }];
    
    
    [_pomelo onRoute:@"PlayerBetEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.target PlayerBetEvent:self.scene];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerBetEvent" object:data];
        });
    }];
    
    [_pomelo onRoute:@"DanmuEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.msgDelegate recievedanmu:data[@"body"][@"msg"] WithUser:data[@"body"][@"user"][@"name"]];
        });
    }];
    
    [_pomelo onRoute:@"GiftEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.msgDelegate recieveGift:[data[@"body"][@"gift_id"] integerValue] WithUser:data[@"body"][@"user_name"]];
        });
    }];
    
    [_pomelo onRoute:@"DealerFinishEvent" withCallback:^(NSDictionary *data){
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself.target TurnFinishEvent:data];
        });
    }];
    
}

#pragma mark -
#pragma mark PomeloDelegate
- (void)PomeloDidDisconnect:(Pomelo *)pomelo withError:(NSError *)error{
    [self.target disconnect:error];
}

- (void)Pomelo:(Pomelo *)pomelo didReceiveMessage:(NSArray *)message{

}



#pragma mark -
#pragma mark UserDatasourceDelegate
- (void)dataHasChanged:(NSArray<User *> *)users{
    [self.datasource viewsHasUpdated:users];
}
@end
