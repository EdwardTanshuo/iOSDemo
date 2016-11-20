//
//  HistoryRequest.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/19/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LuluRequest.h"
#import "Broad.h"

@interface HistoryRequest : LuluRequest
+ (HistoryRequest* _Nullable)sharedRequest;
- (void)getHistoryWithPageSize: (NSUInteger)size
                          page: (NSUInteger)page
                      callback: (void (^_Nullable)(NSArray<Broad* >*  _Nullable, NSError * _Nullable,  NSInteger))complete;
@end
