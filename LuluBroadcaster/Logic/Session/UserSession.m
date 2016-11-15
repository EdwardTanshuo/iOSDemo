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
- (void) setUserName:(NSString*)userName{
    if(!userName){
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:USER_NAME_KEY];
}

#pragma mark password
- (NSString*) password{
    _password = [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORD_KEY];
    return _password;
}
- (void) setPassword:(nonnull NSString*)password{
    if(!password){
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:PASSWORD_KEY];
}

#pragma mark token
- (NSString*) token{
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN_KEY];
    return _token;
}
- (void) setToken:(nonnull NSString*)token{
    if(token){
        if(!token){
            return;
        }
        [SAMKeychain setPassword:token forService:KEYCHAIN_SERVICE account:_userName];
    }else{
        assert(@"username is not exist");
    }
}

#pragma mark methods
- (BOOL)hasToken{
    if(self.token){
        return YES;
    }
    else{
        return NO;
    }
}

@end
