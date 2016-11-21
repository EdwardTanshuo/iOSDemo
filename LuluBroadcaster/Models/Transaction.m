//
//  Transaction.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "Transaction.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

@implementation Transaction
+ (Transaction* _Nonnull)transWithJSON:(id _Nonnull)data{
    Transaction* trans = [[Transaction alloc] init];
    [trans doMappingWithData:data];
    return trans;
}

- (instancetype)init{
    self.type = @"";
    self.tid = @"";
    self.quantity = 0;
    self.issuer = [[User alloc] init];
    self.date = [NSDate new];
    return [super init];
}


- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"_id": KZProperty(tid),
                              @"quantity": KZProperty(quantity),
                              @"type": KZProperty(type),
                              };
    self.issuer = [User userWithJSON:data[@"issuer"]];
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
    self.quantity = -self.quantity;
    
    //date map
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    self.date = [dateFormat dateFromString:data[@"createdAt"]];
}
@end
