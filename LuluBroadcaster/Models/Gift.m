//
//  Gift.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/13/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "Gift.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

@implementation Gift
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.cost = 0;
        self.quantity = 0;
        self.gid = 0;
    }
    return self;
}

+ (Gift* _Nonnull) giftWithJSON:(id _Nonnull)data{
    Gift* gift = [[Gift alloc] init];
    [gift doMappingWithData:data];
    return gift;
}

- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"name": KZProperty(name),
                              @"cost": KZProperty(cost),
                              @"quantity": KZProperty(quantity),
                              @"id": KZProperty(gid)
                              };
    
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}


@end
