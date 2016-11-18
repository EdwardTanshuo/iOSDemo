//
//  ListRequest.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/17/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "ListRequest.h"
#import "Broadcaster.h"

@implementation ListRequest
+ (ListRequest* _Nullable)sharedRequest{
    static ListRequest *sharedMyRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyRequest = [[self alloc] init];
    });
    return sharedMyRequest;
}

- (void)getList: (void (^_Nullable)(NSArray<Broadcaster* >*  _Nullable, NSError * _Nullable))complete{
    [self getWithURL:[self phpUrlByService:@"broadcasters"] Parameters:nil Success:^(id  _Nullable responseObject) {
        NSArray* jsons = responseObject[@"result"][@"items"];
        NSMutableArray* temp = [NSMutableArray arrayWithCapacity:0];
        for(Broadcaster* iter in jsons){
            [temp addObject:[Broadcaster broadcasterPHPWithJSON:iter]];
        }
        NSLog(@"%@", responseObject);
        complete(temp, nil);
    } Failure:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
        complete(nil, error);
    }];
}
@end
