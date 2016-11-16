//
//  LoginRequest.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/13/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LuluRequest.h"

@interface LoginRequest : LuluRequest
+ (LoginRequest* _Nullable)sharedRequest;
- (void)loginWithEmail: (NSString* _Nonnull) email
              Password: (NSString* _Nonnull) password
              Callback: (void (^_Nullable)(Broadcaster * _Nullable, NSError * _Nullable))complete;
@end
