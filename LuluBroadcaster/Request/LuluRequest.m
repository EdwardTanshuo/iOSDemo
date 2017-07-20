//
//  LuluRequest.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/13/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LuluRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "UserSession.h"

@interface LuluRequest(){
    BOOL lock;
}
@property (nonatomic, strong, nullable) AFHTTPSessionManager* manager;
@end

@implementation LuluRequest
- (instancetype)init{
    lock = NO;
    
    _base_url = BASE_URL;
    _php_url = PHP_URL;
    
    _apis = @{@"XXXXXXXXX": @"XXXXXXXXX", @"XXXXXXXXX": @"XXXXXXXXX", @"XXXXXXXXX": @"XXXXXXXXX", @"XXXXXXXXX": @"XXXXXXXXX", @"XXXXXXXXX": @"XXXXXXXXX", @"XXXXXXXXX": @"XXXXXXXXX"};
    _manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    [securityPolicy setAllowInvalidCertificates:YES];
    _manager.securityPolicy = securityPolicy;
    [_manager.requestSerializer setValue:@"XXXXXXXXX" forHTTPHeaderField:@"XXXXXXXXX"];
   
    return [super init];
}

- (void)addAuth: (NSString* _Nonnull)token{
     [_manager.requestSerializer setValue:token forHTTPHeaderField:@"XXXXXXXXX"];
}

- (void)dealloc{
    self.manager = nil;
}

- (NSString*) urlByService:(NSString*) service{
    if([_apis objectForKey:service]){
        return [NSString stringWithFormat:@"%@%@", _base_url, _apis[service]];
    }
    else{
        return @"";
    }
}
- (NSString* _Nonnull) phpUrlByService:(NSString* _Nonnull) service{
    if([_apis objectForKey:service]){
        return [NSString stringWithFormat:@"%@%@", _php_url, _apis[service]];
    }
    else{
        return @"";
    }
}

- (void)postWithURL:(NSString* _Nonnull)url
         Parameters: (id _Nullable)params
            Success: (void (^_Nullable)(id _Nullable  responseObject)) success
            Failure: (void (^_Nullable)(NSError * _Nonnull error)) failure

{
    if(lock){
        NSError* err = nil;
        err = [NSError errorWithDomain:@"XXXXXXXXX" code:500 userInfo:@{@"XXXXXXXXX": @"XXXXXXXXX"}];
        return failure(err);
    }
    lock = YES;
    UserSession* session = [[UserSession alloc] init];
    if(session.token){
        [self addAuth:session.token];
    }
    [_manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        lock = NO;
        return success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        lock = NO;
        return failure(error);
    }];
}

- (void)getWithURL:(NSString* _Nonnull)url
        Parameters: (id _Nullable)params
           Success: (void (^_Nullable)(id _Nullable  responseObject)) success
           Failure: (void (^_Nullable)(NSError * _Nonnull error)) failure

{
    if(lock){
        NSError* err = nil;
        err = [NSError errorWithDomain:@"XXXXXXXXX" code:500 userInfo:@{@"XXXXXXXXX": @"XXXXXXXXX"}];
        return failure(err);
    }
    lock = YES;
    UserSession* session = [[UserSession alloc] init];
    if(session.token){
        [self addAuth:session.token];
    }
    [_manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        lock = NO;
        return success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        lock = NO;
        return failure(error);
    }];
}

- (NSError* _Nullable)checkResponse: (id _Nullable)response{
    NSError* error = nil;
    if(!response){
        error = [NSError errorWithDomain:@"XXXXXXXXX" code:404 userInfo:@{@"XXXXXXXXX": @"XXXXXXXXX"}];
        return error;
    }
    else if(![[response objectForKey:@"XXXXXXXXX"] isKindOfClass:[NSNumber class]]){
        error = [NSError errorWithDomain:@"XXXXXXXXX" code:403 userInfo:@{@"XXXXXXXXX": @"XXXXXXXXX"}];
        return error;
    }
    else if([[response objectForKey:@"XXXXXXXXX"] integerValue] != 0){
        NSString* message = [response objectForKey:@"XXXXXXXXX"];
        if(!message){
            message = @"XXXXXXXXX";
        }
        error = [NSError errorWithDomain:@"XXXXXXXXX" code:[[response objectForKey:@"XXXXXXXXX"] integerValue] userInfo:@{@"XXXXXXXXX": message}];
        return error;
    }
    return nil;
}


@end
