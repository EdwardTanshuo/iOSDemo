//
//  Record.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "Record.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

@implementation Record
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.day = @"";
        self.start_time = @"";
        self.finish_time = @"";
        self.duration = 0;
    }
    return self;
}

+ (Record* _Nonnull) recordWithJSON:(id _Nonnull)data{
    Record* record = [[Record alloc] init];
    [record doMappingWithData:data];
    return record;
}

- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"day": KZProperty(day),
                              @"start_time": KZProperty(start_time),
                              @"finish_time": KZProperty(finish_time),
                              @"duration": KZProperty(duration)
                              };
    
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}
@end
