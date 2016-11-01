//
//  UserSession.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#define KEYCHAIN_SERVICE @"LULUVR_BROADCASTER"

#define USER_NAME_KEY @"userName"
#define PASSWORD_KEY @"password"
#define TOKEN_KEY @"token"

#import "UserSession.h"
#import <SAMKeychain/SAMKeychain.h>

@interface UserSession()

@end

@implementation UserSession
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize token = _token;

#pragma mark userName
- (NSString*) userName{
    _userName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_KEY];
    return _userName;
}
- (void) setUserName:(nonnull NSString*)new_value{
    [[NSUserDefaults standardUserDefaults] setObject:new_value forKey:USER_NAME_KEY];
}

#pragma mark password
- (NSString*) password{
    _password = [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORD_KEY];
    return _password;
}
- (void) setPassword:(nonnull NSString*)new_value{
    [[NSUserDefaults standardUserDefaults] setObject:new_value forKey:PASSWORD_KEY];
}

#pragma mark token
- (NSString*) token{
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN_KEY];
    return _token;
}
- (void) setToken:(nonnull NSString*)new_value{
    if(_userName){
        [SAMKeychain setPassword:new_value forService:new_value account:_userName];
    }else{
        assert(@"username is not exist");
    }
}

@end
