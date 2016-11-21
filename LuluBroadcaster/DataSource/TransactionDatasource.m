//
//  TransactionDatasource.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "TransactionDatasource.h"
#import "TransactionRequest.h"
#define PAGE_SIZE 20
@interface TransactionDatasource (){
    NSMutableArray *_transactions;
    BOOL lock;
}
@property (nonatomic, assign) NSUInteger currentPage;
@end

@implementation TransactionDatasource
@synthesize transactions = _transactions;
- (instancetype)init{
    lock = NO;
    _currentPage = 1;
    _total = 0;
    return [super init];
}

#pragma mark -
#pragma mark getter/setter
- (NSArray *)transactions
{
    if(!_transactions){
        _transactions = [NSMutableArray arrayWithArray:@[]];
    }
    return [_transactions copy];
}

- (void)setTransactions:(NSArray *)transactions
{
    if(!transactions){
        _transactions = [NSMutableArray arrayWithArray:@[]];
    }
    else if ([_transactions isEqualToArray:transactions] == NO)
    {
        _transactions = [transactions mutableCopy];
    }
    [_delegate dataHasChanged:_transactions];
}

#pragma mark -
#pragma mark methods

- (void)fetchNew{
    if(lock){
        return;
    }
    lock = YES;
    __weak TransactionDatasource* wself = self;
    [[TransactionRequest sharedRequest] getTransactionsWithPageSize:PAGE_SIZE page:_currentPage callback:^(NSArray<Transaction *> * _Nullable transactions, NSError * _Nullable error, NSInteger num) {
        lock = NO;
        if(!error){
            wself.currentPage++;
            self.total = num;
            wself.transactions = [wself.transactions arrayByAddingObjectsFromArray:transactions];
        }
        else{
            self.total = num;
            [wself.delegate dataHasFailed:error];
        }
    }];
    
}

- (void)reset{
    if(lock){
        return;
    }
    lock = YES;
    __weak TransactionDatasource* wself = self;
    _currentPage = 1;
    [[TransactionRequest sharedRequest] getTransactionsWithPageSize:PAGE_SIZE page:_currentPage callback:^(NSArray<Transaction *> * _Nullable transactions, NSError * _Nullable error, NSInteger num) {
        lock = NO;
        if(!error){
            self.total = num;
            wself.transactions = transactions;
        }
        else{
            self.total = num;
            [wself.delegate dataHasFailed:error];
        }
    }];
}

- (NSInteger)numOfRows{
    return [self.transactions count];
}

- (Transaction* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath{
    return self.transactions[indexPath.row];
}

@end
