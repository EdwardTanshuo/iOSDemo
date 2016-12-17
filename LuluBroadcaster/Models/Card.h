//
//  Card.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CardType) {
    CardTypeNORMAL,
    CardTypeSUPER,
    CardTypeTRANSFORM
};

@interface Card : NSObject
@property (nonatomic, strong, nonnull) NSString*    name;
@property (nonatomic, strong, nonnull) NSString*    thumb;
@property (nonatomic, strong, nonnull) NSString*    model;
@property (nonatomic, assign) NSInteger             value;
@property (nonatomic, assign) NSInteger             foreignId;
@property (nonatomic, strong, nonnull) NSString*    deckId;
@property (nonatomic, assign) double                weight;
@property (nonatomic, assign) CardType              type;
+ (Card* _Nonnull) cardWithJSON:(id _Nonnull)data;
@end
