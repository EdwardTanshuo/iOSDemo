//
//  Scene.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "User.h"
#import "CardValue.h"
#import "Broadcaster.h"

typedef NS_ENUM(NSInteger, SceneStatus) {
    SceneStatusInit,
    SceneStatusBetting,
    SceneStatusPlayerTurn,
    SceneStatusDealerTurn
};

@interface Scene : NSObject
@property (nonatomic, strong, nonnull) NSString*                                    room;
@property (nonatomic, assign) NSInteger                                             turns;
@property (nonatomic, assign) SceneStatus                                           status;
@property (nonatomic, strong, nonnull) NSDictionary<NSString*, User*>*              players;
@property (nonatomic, strong, nonnull) NSDictionary<NSString*, NSArray<Card*>*>*    player_platfroms;
@property (nonatomic, strong, nonnull) NSDictionary<NSString*, CardValue*>*         player_values;
@property (nonatomic, strong, nonnull) NSDictionary<NSString*, NSNumber*>*          player_bets;
@property (nonatomic, strong, nonnull) Broadcaster*                                 dealer;
@property (nonatomic, strong, nonnull) NSArray<Card*>*                              dealer_platfrom;
@property (nonatomic, strong, nonnull) CardValue*                                   dealer_value;
@property (nonatomic, assign) NSInteger                                             dealer_bets;
@property (nonatomic, strong, nonnull) NSArray<Card*>*                              dealer_deck;
@property (nonatomic, assign) double                                                durationBet;
@property (nonatomic, assign) double                                                durationPlayerTurn;
@property (nonatomic, assign) double                                                durationDealerTurn;

+ (Scene* _Nonnull) sceneWithJSON:(id _Nonnull)data;

- (NSUInteger) totalBet;
@end





