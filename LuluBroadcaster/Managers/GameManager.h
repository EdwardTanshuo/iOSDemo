//
//  GameManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/7/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scene.h"
#import "Gift.h"
#import "UserDataSource.h"

#define GAME_IP @"game.mofangvr.com"
#define GAME_PORT 3020

typedef void (^_Nullable GameManagerCallback)(id _Nullable argsData);
typedef void (^_Nullable GameManagerResultCallback)(NSError* _Nullable err, Scene* _Nullable scene);
typedef void (^_Nullable GameManagerDrawCardCallback)(NSError* _Nullable err, Card* _Nullable card, CardValue* _Nullable value);
typedef void (^_Nullable GiftsCallback)(NSError* _Nullable err, NSArray<Gift*>* _Nullable list);

@protocol GameManagerDelegate
- (void)entryCallBack:(id _Nullable) argsData;
- (void)createCallBack:(id _Nullable) argsData;
- (void)betCallBack:(id _Nullable) argsData;
- (void)startCallBack:(id _Nullable) argsData;
- (void)endDealerCallBack:(id _Nullable) argsData;
- (void)endCallBack:(id _Nullable) argsData;
- (void)drawCallBack:(id _Nullable) argsData;
- (void)finishTurnCallBack:(id _Nullable) argsData;
@end

@protocol GameManagerEvent
- (void)PlayerEnterEvent: (User* _Nullable)user;
- (void)PlayerLeaveEvent: (User* _Nullable)user;
- (void)NewTurnEvent: (Scene* _Nullable)scene;
- (void)BetStartEvent: (Scene* _Nullable)scene;
- (void)GameStartEvent: (Scene* _Nullable)scene;
- (void)PlayerBetEvent: (Scene* _Nullable)scene;
- (void)TurnFinishEvent: (NSDictionary* _Nullable)data;
- (void)didConnected;
- (void)disconnect:(NSError* _Nullable)error;
@end

@protocol MessageEvent
- (void)recievedanmu: (NSString* _Nullable)text WithUser: (NSString* _Nullable)user;
- (void)recieveGift: (NSInteger)gid WithUser: (NSString* _Nullable)user;
@end

@protocol GameManagerDatasource
- (void) sceneHasUpdated: (Scene* _Nullable)scene;
- (void) viewsHasUpdated: (NSArray<User*>* _Nullable)users;
@end

@interface GameManager : NSObject
@property (nonatomic, strong, nonnull)  Scene*                              scene;
@property (nonatomic, weak, nullable)   id<GameManagerDelegate>             delegate;
@property (nonatomic, weak, nullable)   id<GameManagerEvent>                target;
@property (nonatomic, weak, nullable)   id<MessageEvent>                    msgDelegate;
@property (nonatomic, weak, nullable)   id<GameManagerDatasource>           datasource;
@property (nonatomic, strong, nullable) UserDataSource*                     userDatasource;


+ (GameManager* _Nonnull)sharedManager;

#pragma mark -
#pragma mark PomeloReuqests
- (NSArray<Gift*>* _Nonnull)giftList;

- (void)entry: (NSString* _Nonnull)room;
- (void)createGame: (NSString* _Nonnull)room;
- (void)startBet: (NSString* _Nonnull)room;
- (void)startGame: (NSString* _Nonnull)room;
- (void)endDealer: (NSString* _Nonnull)room;
- (void)endGame: (NSString* _Nonnull)room;
- (void)drawCard: (NSString* _Nonnull)room;
- (void)finishTurn: (NSString* _Nonnull)room;
- (void)sendFaceCoordinate: (NSDictionary* _Nonnull)params;

- (void)connect;

- (void)connectWithCallback: (GameManagerCallback)callback;
- (void)entryWithCallback: (GameManagerCallback)callback room: (NSString* _Nonnull)room;
- (void)createGameWithCallback: (GameManagerCallback)callback room: (NSString* _Nonnull)room;
- (void)drawCardWithCallback: (GameManagerDrawCardCallback)callback room: (NSString* _Nonnull)room;
- (void)finishTurnWithCallback: (GameManagerResultCallback)callback room: (NSString* _Nonnull)room;
- (void)requestGiftsWithCallback: (GiftsCallback)callback;
- (void)enterGameWithCallback: (GameManagerResultCallback)callback room: (NSString* _Nonnull)room;

- (NSError* _Nullable) makeError: (id _Nullable)data;
- (Scene* _Nullable) makeScene: (id _Nullable)data;
- (NSInteger)makeCode: (id _Nullable)data;

- (NSUInteger) numberOfDiamond;

@end
