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
#import "UserSession.h"
#import "SettingSession.h"

@interface LoginRequest()

@end

@implementation LoginRequest

#pragma mark singleton
+ (LoginRequest* _Nullable)sharedRequest {
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

- (void)loginWithEmail: (NSString* _Nonnull) email
              Password: (NSString* _Nonnull) password
              Callback: (void (^_Nullable)(Broadcaster * _Nullable, NSError * _Nullable))complete{
    NSLog(@"%@",[self urlByService:@"login"]);
    [self postWithURL:[self urlByService:@"login"] Parameters:@{@"email": email, @"password": password} Success:^(id  _Nullable responseObject) {
        
        //check err
        NSError* err = [self checkResponse:responseObject];
        
        //parse result
        if(err){
            complete(nil, err);
        }
        else{
            //save token
            if(responseObject[@"data"][@"token"]){
                UserSession* session = [[UserSession alloc] init];
                [session saveToken:responseObject[@"data"][@"token"] WithEmail:email];
            }
            
            if(responseObject[@"data"][@"user"]){
                complete([Broadcaster broadcasterWithJSON:responseObject[@"data"][@"user"]], nil);
            }
            else{
                complete([[Broadcaster alloc] init], nil);
            }
        }
    } Failure:^(NSError * _Nonnull error) {
        complete(nil, error);
    }];
}
@end
