//
//  LoginRequest.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/13/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LoginRequest.h"
#import "Broadcaster.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

@interface LoginRequest()

@end

@implementation LoginRequest

#pragma mark singleton
+ (LoginRequest*)sharedRequest {
    static LoginRequest *sharedMyRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyRequest = [[self alloc] init];
    });
    return sharedMyRequest;
}

- (instancetype)init{
    return [super init];
}

- (void)login:(void (^)(Broadcaster * _Nullable, NSError * _Nullable))complete{
    [self postWithURL:[self urlByService:@"login"] Parameters:@{} Success:^(id  _Nullable responseObject) {
        
    } Failure:^(NSError * _Nonnull error) {
        complete(nil, error);
    }];
}
@end
