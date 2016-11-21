//
//  TransactionDatasource.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@protocol TransactionDatasourceDelegate <NSObject>
- (void)dataHasChanged: (NSArray<Transaction*>* _Nonnull) transactions;
- (void)dataHasFailed: (NSError* )error;
@end

@interface TransactionDatasource : NSObject
@property (nonatomic, strong, nonnull) NSArray<Transaction*>* transactions;
@property (nonatomic, weak, nullable) id<TransactionDatasourceDelegate> delegate;
@property (nonatomic, assign) NSInteger total;
- (void)fetchNew;
- (void)reset;
- (NSInteger)numOfRows;
- (Transaction* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath;
@end
