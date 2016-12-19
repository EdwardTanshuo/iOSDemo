//
//  GameManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/7/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scene.h"
#import "UserDataSource.h"

#define GAME_IP @"10.10.17.199"
#define GAME_PORT 3020

typedef void (^_Nullable GameManagerCallback)(id _Nullable argsData);
typedef void (^_Nullable GameManagerResultCallback)(NSError* _Nullable err, Scene* _Nullable argsData);

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
- (void)didConnected;
- (void)disconnect:(NSError* _Nullable)error;
@end

@protocol GameManagerDatasource
- (void) sceneHasUpdated: (Scene* _Nullable)scene;
- (void) viewsHasUpdated: (NSArray<User*>* _Nullable)users;
@end

@interface GameManager : NSObject
@property (nonatomic, strong, nonnull) Scene* scene;
@property (nonatomic, weak, nullable)   id<GameManagerDelegate>             delegate;
@property (nonatomic, weak, nullable)   id<GameManagerEvent>                target;
@property (nonatomic, weak, nullable)   id<GameManagerDatasource>           datasource;
@property (nonatomic, strong, nullable) UserDataSource*                     userDatasource;


+ (GameManager* _Nonnull)sharedManager;

#pragma mark -
#pragma mark PomeloReuqests
- (void)entry: (NSString* _Nonnull)room;
- (void)createGame: (NSString* _Nonnull)room;
- (void)startBet: (NSString* _Nonnull)room;
- (void)startGame: (NSString* _Nonnull)room;
- (void)endDealer: (NSString* _Nonnull)room;
- (void)endGame: (NSString* _Nonnull)room;
- (void)drawCard: (NSString* _Nonnull)room;
- (void)finishTurn: (NSString* _Nonnull)room;
- (void)connect;

- (void)connectWithCallback: (GameManagerCallback)callback;
- (void)entryWithCallback: (GameManagerCallback)callback room: (NSString* _Nonnull)room;
- (void)createGameWithCallback: (GameManagerCallback)callback room: (NSString* _Nonnull)room;

- (void)enterGameWithCallback: (GameManagerResultCallback)callback room: (NSString* _Nonnull)room;

- (NSError* _Nullable) makeError: (id _Nullable)data;
- (Scene* _Nullable) makeScene: (id _Nullable)data;
- (NSInteger)makeCode: (id _Nullable)data;
@end
