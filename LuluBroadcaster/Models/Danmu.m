//
//  Danmu.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "Danmu.h"

@implementation Danmu
- (instancetype _Nonnull)initWithUser:(NSString* _Nonnull)user WithMessage:(NSString* _Nonnull) message WithType:(DanmuType)type{
    self.user = user;
    self.word = message;
    self.type = type;
    return [super init];
}
@end
