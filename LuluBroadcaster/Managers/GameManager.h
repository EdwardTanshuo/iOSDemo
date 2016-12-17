//
//  GameManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/7/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scene.h"

#define GAME_IP @"10.10.17.182"
#define GAME_PORT 3020

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
- (void)PlayerEnterEvent: (NSDictionary* _Nullable)data;
- (void)PlayerLeaveEvent: (NSDictionary* _Nullable)data;
- (void)NewTurnEvent: (NSDictionary* _Nullable)data;
- (void)didConnected;
- (void)disconnect:(NSError* _Nullable)error;
@end

@interface GameManager : NSObject
@property (nonatomic, strong, nonnull) Scene* scene;
@property (nonatomic, weak, nullable) id<GameManagerDelegate> delegate;
@property (nonatomic, weak, nullable) id<GameManagerEvent> target;
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
@end
