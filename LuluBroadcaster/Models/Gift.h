//
//  Gift.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/13/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gift : NSObject
@property(nonatomic, assign) NSInteger gid;
@property(nonatomic, assign) NSInteger quantity;
@property(nonatomic, assign) NSInteger cost;
@property(nonatomic, strong, nonnull) NSString* name;

+ (Gift* _Nonnull) giftWithJSON:(id _Nonnull)data;
@end
