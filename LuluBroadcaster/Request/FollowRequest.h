//
//  FollowRequest.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/10/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "LuluRequest.h"
#import "User.h"

@interface FollowRequest : LuluRequest
+ (FollowRequest* _Nullable)sharedRequest;
- (void)fetchFollowWithCompletion: (void (^_Nullable)(NSArray<User* >*  _Nullable, NSError * _Nullable))complete;
@end
