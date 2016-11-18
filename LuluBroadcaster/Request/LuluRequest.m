//
//  LuluRequest.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/13/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LuluRequest.h"
#import <AFNetworking/AFNetworking.h>

@interface LuluRequest()
@property (nonatomic, strong, nullable) AFHTTPSessionManager* manager;
@end

@implementation LuluRequest
- (instancetype)init{
    _base_url = BASE_URL;
    _php_url = PHP_URL;
    
    _apis = @{@"login": @"login", @"broadcasters": @"account/feed"};
    _manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    [securityPolicy setAllowInvalidCertificates:YES];
    _manager.securityPolicy = securityPolicy;
    [_manager.requestSerializer setValue:@"d858bd235c7faf19f5da18a1118788e2" forHTTPHeaderField:@"X_MCV_TOKEN"];
   
    return [super init];
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
    [_manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure(error);
    }];
}

- (void)getWithURL:(NSString* _Nonnull)url
        Parameters: (id _Nullable)params
           Success: (void (^_Nullable)(id _Nullable  responseObject)) success
           Failure: (void (^_Nullable)(NSError * _Nonnull error)) failure

{
    [_manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure(error);
    }];
}

- (NSError* _Nullable)checkResponse: (id _Nullable)response{
    NSError* error = nil;
    if(!response){
        error = [NSError errorWithDomain:@"com.mofangvr.lulu" code:404 userInfo:@{@"msg": @"unhandle error"}];
        return error;
    }
    else if(![[response objectForKey:@"errCode"] isKindOfClass:[NSNumber class]]){
        error = [NSError errorWithDomain:@"com.mofangvr.lulu" code:403 userInfo:@{@"msg": @"unsupport response format, must include errCode"}];
        return error;
    }
    else if([[response objectForKey:@"errCode"] integerValue] != 0){
        NSString* message = [response objectForKey:@"message"];
        if(!message){
            message = @"no info";
        }
        error = [NSError errorWithDomain:@"com.mofangvr.lulu" code:[[response objectForKey:@"errCode"] integerValue] userInfo:@{@"msg": message}];
        return error;
    }
    return nil;
}


@end
