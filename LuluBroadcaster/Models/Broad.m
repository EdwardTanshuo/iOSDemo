//
//  Broad.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/19/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "Broad.h"
#import <KZPropertyMapper/KZPropertyMapper.h>
@implementation Broad
+ (Broad* _Nonnull)broadWithJSON:(id _Nonnull)data{
    Broad* broad = [[Broad alloc] init];
    [broad doMappingWithData:data];
    return broad;
}

- (instancetype)init{
    self.bid = @"";
    self.start = [NSDate new];
    self.end = [NSDate new];
    self.value = 0;
    return [super init];
}


- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"_id": KZProperty(bid),
                              @"value": KZProperty(value)
                              };
    //date map
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    self.start = [dateFormat dateFromString:data[@"startAt"]];
    self.end = [dateFormat dateFromString:data[@"endAt"]];
    
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}
@end
