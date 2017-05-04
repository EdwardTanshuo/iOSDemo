//
//  Danmu.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NormalDanmuType,
    GiftDanmuType
} DanmuType;

@interface Danmu : NSObject
@property (nonatomic, strong, nonnull) NSString* user;
@property (nonatomic, strong, nonnull) NSString* word;
@property (nonatomic, assign) DanmuType type;

- (instancetype _Nonnull)initWithUser:(NSString* _Nonnull)user WithMessage:(NSString* _Nonnull) message WithType:(DanmuType)type;

@end
