//
//  Card.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "Card.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

@implementation Card
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.thumb = @"";
        self.model = @"";
        self.value = 0;
        self.deckId = @"default";
        self.weight = 0.0f;
    }
    return self;
}

+ (Card* _Nonnull) cardWithJSON:(id _Nonnull)data{
    Card* card = [[Card alloc] init];
    [card doMappingWithData:data];
    return card;
}

- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"name": KZProperty(name),
                              @"thumb": KZProperty(thumb),
                              @"value": KZProperty(value),
                              @"deckId": KZProperty(deckId),
                              @"weight": KZProperty(weight)
                              };
    
    //type
    id temp_type = [data objectForKey:@"type"];
    if(temp_type && [temp_type isKindOfClass:[NSString class]]){
        if([temp_type isEqualToString:@"NORMAL"]){
            self.type = CardTypeNORMAL;
        }
        else if([temp_type isEqualToString:@"SUPER"]){
            self.type = CardTypeSUPER;
        }
        else if([temp_type isEqualToString:@"TRANSFORM"]){
            self.type = CardTypeTRANSFORM;
        }
    }
    
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}

@end
