//
//  TransactionRequst.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "TransactionRequest.h"

@implementation TransactionRequest
+ (TransactionRequest* _Nullable)sharedRequest{
    static TransactionRequest *sharedMyRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyRequest = [[self alloc] init];
    });
    return sharedMyRequest;
}

- (void)getTransactionsWithPageSize: (NSUInteger)size
                               page: (NSUInteger)page
                           callback: (void (^_Nullable)(NSArray<Transaction* >*  _Nullable, NSError * _Nullable,  NSInteger))complete{
    [self getWithURL:[self urlByService:@"transactions"] Parameters:@{@"pagenum": @(page), @"pagesize": @(size)} Success:^(id  _Nullable responseObject) {
        NSError* err = [self checkResponse:responseObject];
        //parse result
        if(err){
            return complete(nil, err, 0);
        }
        
        NSArray* jsons = responseObject[@"data"][@"transactions"];
        NSMutableArray* temp = [NSMutableArray arrayWithCapacity:0];
        for(id iter in jsons){
            [temp addObject:[Transaction transWithJSON:iter]];
        }
        NSInteger num = [responseObject[@"data"][@"totalCount"] integerValue];
        complete(temp, nil, num);
        
    } Failure:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
        complete(nil, error, 0);
    }];
}
@end
