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
    _apis = @{@"login": @"login"};
    _manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    [securityPolicy setAllowInvalidCertificates:YES];
    _manager.securityPolicy = securityPolicy;
   
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



@end
