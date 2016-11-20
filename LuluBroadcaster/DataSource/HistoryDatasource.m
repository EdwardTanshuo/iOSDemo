//
//  HistoryDatasource.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "HistoryDatasource.h"
#import "HistoryRequest.h"
#define PAGE_SIZE 20
@interface HistoryDatasource (){
    NSMutableArray *_histories;
    BOOL lock;
}
@property (nonatomic, assign) NSUInteger currentPage;

@end

@implementation HistoryDatasource
@synthesize histories = _histories;

- (instancetype)init{
    lock = NO;
    _currentPage = 1;
    _total = 0;
    return [super init];
}

#pragma mark -
#pragma mark getter/setter
- (NSArray *)histories
{
    if(!_histories){
        _histories = [NSMutableArray arrayWithArray:@[]];
    }
    return [_histories copy];
}

- (void)setHistories:(NSArray *)histories
{
    if(!histories){
        _histories = [NSMutableArray arrayWithArray:@[]];
    }
    else if ([_histories isEqualToArray:histories] == NO)
    {
        _histories = [histories mutableCopy];
    }
    [_delegate dataHasChanged:_histories];
}

#pragma mark -
#pragma mark methods

- (void)fetchNew{
    if(lock){
        return;
    }
    lock = YES;
    __weak HistoryDatasource* wself = self;
    [[HistoryRequest sharedRequest] getHistoryWithPageSize:PAGE_SIZE page:_currentPage callback:^(NSArray<Broad *> * _Nullable broads, NSError * _Nullable error, NSInteger num) {
        lock = NO;
        if(!error){
            wself.currentPage++;
            self.total = num;
            wself.histories = [wself.histories arrayByAddingObjectsFromArray:broads];
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
    __weak HistoryDatasource* wself = self;
    _currentPage = 1;
    [[HistoryRequest sharedRequest] getHistoryWithPageSize:PAGE_SIZE page:_currentPage callback:^(NSArray<Broad *> * _Nullable broads, NSError * _Nullable error, NSInteger num) {
        lock = NO;
        if(!error){
            self.total = num;
            wself.histories = broads;
        }
        else{
            self.total = num;
            [wself.delegate dataHasFailed:error];
        }
    }];
}

- (NSInteger)numOfRows{
    return [self.histories count];
}

- (Broad* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath{
    return self.histories[indexPath.row];
}


@end
