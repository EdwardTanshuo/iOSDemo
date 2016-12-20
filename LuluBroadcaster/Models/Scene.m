//
//  Scene.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "Scene.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

@implementation Scene

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dealer = [[Broadcaster alloc] init];
        self.dealer_bets = 0;
        self.dealer_deck = @[];
        self.dealer_platfrom = @[];
        self.dealer_value = [[CardValue alloc] init];
        
        self.players = @{};
        self.player_bets = @{};
        self.player_bets = @{};
        self.player_platfroms = @{};
        
        self.turns = 0;
        self.status = SceneStatusInit;
        self.room = @"";
    }
    return self;
}

+ (Scene* _Nonnull) sceneWithJSON:(id _Nonnull)data{
    Scene* scene = [[Scene alloc] init];
    [scene doMappingWithData:data];
    return scene;
}

- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"room": KZProperty(room),
                              @"dealer_bets": KZProperty(dealer_bets),
                              @"turns": KZProperty(turns),
                              };
    
    //dealer
    id dealer = [data objectForKey:@"dealer"];
    if(dealer && [dealer isKindOfClass:[NSDictionary class]]){
        Broadcaster* temp = [Broadcaster broadcasterPHPWithJSON:dealer];
        self.dealer = temp;
    }
    
    //dealer_deck
    id dealerDeck = [data objectForKey:@"dealer_deck"];
    if(dealerDeck && [dealerDeck isKindOfClass:[NSArray class]]){
        NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity:0];
        for(id card in dealerDeck){
            Card* cardModel = [Card cardWithJSON:card];
            [tempArray addObject:cardModel];
        }
        self.dealer_deck = tempArray;
    }
    
    //dealer_platfrom
    id dealerPlatfrom = [data objectForKey:@"dealer_platfrom"];
    if(dealerPlatfrom && [dealerPlatfrom isKindOfClass:[NSArray class]]){
        NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity:0];
        for(id card in dealerPlatfrom){
            Card* cardModel = [Card cardWithJSON:card];
            [tempArray addObject:cardModel];
        }
        self.dealer_platfrom = tempArray;
    }
    
    //dealer_value
    id dealerValue = [data objectForKey:@"dealer_value"];
    if(dealerValue){
        self.dealer_value = [CardValue valueWithJSON:dealerValue];
    }
    
    //status
    id temp_status = [data objectForKey:@"status"];
    if(temp_status && [temp_status isKindOfClass:[NSString class]]){
        if([temp_status isEqualToString:@"init"]){
            self.status = SceneStatusInit;
        }
        else if([temp_status isEqualToString:@"betting"]){
            self.status = SceneStatusBetting;
        }
        else if([temp_status isEqualToString:@"player_started"]){
            self.status = SceneStatusPlayerTurn;
        }
        else if([temp_status isEqualToString:@"dealer_turn"]){
            self.status = SceneStatusDealerTurn;
        }
    }
    
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}

@end
