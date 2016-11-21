//
//  TransactionRequst.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LuluRequest.h"
#import "Transaction.h"

@interface TransactionRequest : LuluRequest
+ (TransactionRequest* _Nullable)sharedRequest;
- (void)getTransactionsWithPageSize: (NSUInteger)size
                          page: (NSUInteger)page
                      callback: (void (^_Nullable)(NSArray<Transaction* >*  _Nullable, NSError * _Nullable,  NSInteger))complete;
@end
