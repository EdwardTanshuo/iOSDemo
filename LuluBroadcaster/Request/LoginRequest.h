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
- (void)login: (void (^_Nullable)(Broadcaster* _Nullable broadcaster,  NSError* _Nullable  error)) complete;
@end
