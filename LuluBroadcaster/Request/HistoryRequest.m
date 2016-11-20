//
//  HistoryRequest.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/19/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "HistoryRequest.h"

@implementation HistoryRequest
+ (HistoryRequest* _Nullable)sharedRequest{
    static HistoryRequest *sharedMyRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyRequest = [[self alloc] init];
    });
    return sharedMyRequest;
}

- (void)getHistoryWithPageSize: (NSUInteger)size
                        page: (NSUInteger)page
                      callback: (void (^_Nullable)(NSArray<Broad* >*  _Nullable, NSError * _Nullable,  NSInteger))complete{
    [self getWithURL:[self urlByService:@"history"] Parameters:@{@"pagenum": @(page), @"pagesize": @(size)} Success:^(id  _Nullable responseObject) {
        NSArray* jsons = responseObject[@"data"][@"data"];
        NSMutableArray* temp = [NSMutableArray arrayWithCapacity:0];
        for(Broadcaster* iter in jsons){
            [temp addObject:[Broad broadWithJSON:iter]];
        }
        NSInteger num = [responseObject[@"data"][@"totalCount"] integerValue];
        complete(temp, nil, num);
    
    } Failure:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
        complete(nil, error, 0);
    }];
    
}

@end
