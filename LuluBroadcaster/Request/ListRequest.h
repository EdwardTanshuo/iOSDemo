//
//  ListRequest.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/17/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LuluRequest.h"

@interface ListRequest : LuluRequest
+ (ListRequest* _Nullable)sharedRequest;
- (void)getList: (void (^_Nullable)(NSArray<Broadcaster* >*  _Nullable, NSError * _Nullable))complete;
@end
