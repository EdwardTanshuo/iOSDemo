//
//  CardValue.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "CardValue.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

@implementation CardValue
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.busted = NO;
        self.value = 0;
    }
    return self;
}

+ (CardValue* _Nonnull) valueWithJSON:(id _Nonnull)data{
    CardValue* value = [[CardValue alloc] init];
    [value doMappingWithData:data];
    return value;
}

- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"busted": KZProperty(busted),
                              @"value": KZProperty(value)
                           };
    
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}

@end
