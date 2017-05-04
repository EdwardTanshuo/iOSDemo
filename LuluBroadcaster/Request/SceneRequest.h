//
//  SceneRequest.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "LuluRequest.h"
#import "Record.h"

@interface SceneRequest : LuluRequest
+ (SceneRequest* _Nullable)sharedRequest;
- (void)fetchScenesWithCompletion: (void (^_Nullable)(NSArray<Record* >*  _Nullable, NSError * _Nullable))complete;
@end
