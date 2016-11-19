//
//  Danmu.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "Danmu.h"

@implementation Danmu
- (instancetype _Nonnull)initWithUser:(NSString* _Nonnull)user WithMessage:(NSString* _Nonnull) message{
    self.user = user;
    self.word = message;
    return [super init];
}
@end
