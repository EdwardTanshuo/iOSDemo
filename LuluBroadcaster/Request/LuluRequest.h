//
//  LuluRequest.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/13/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#define BASE_URL @"http://122.112.227.196/"
#define PHP_URL @"http://122.112.227.196/"

#import <Foundation/Foundation.h>
#import "Broadcaster.h"

@interface LuluRequest : NSObject
@property (nonatomic, readonly, copy, nonnull) NSString* base_url;
@property (nonatomic, readonly, copy, nonnull) NSString* php_url;
@property (nonatomic, readonly, copy, nonnull) NSDictionary* apis;

- (NSString* _Nonnull) urlByService:(NSString* _Nonnull) service;
- (NSString* _Nonnull) phpUrlByService:(NSString* _Nonnull) service;

- (void)postWithURL: (NSString* _Nonnull)url
         Parameters: (id _Nullable)params
            Success: (void (^_Nullable)(id _Nullable responseObject)) success
            Failure: (void (^_Nullable)(NSError * _Nonnull error)) failure;

- (void)getWithURL: (NSString* _Nonnull)url
        Parameters: (id _Nullable)params
           Success: (void (^_Nullable)(id _Nullable responseObject)) success
           Failure: (void (^_Nullable)(NSError * _Nonnull error)) failure;

- (NSError* _Nullable)checkResponse: (id _Nullable)response;
@end
