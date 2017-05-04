//
//  SceneDatasource.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "SceneDatasource.h"
#import <UIKit/UIKit.h>

@interface SceneDatasource(){
    NSMutableArray *_record;
}

@end

@implementation SceneDatasource
@synthesize records = _record;

#pragma mark -
#pragma mark getter/setter
- (NSArray *)records
{
    if(!_record){
        _record = [NSMutableArray arrayWithArray:@[]];
    }
    return [_record copy];
}

- (void)setRecords:(NSArray *)records
{
    if(!records){
        _record = [NSMutableArray arrayWithArray:@[]];
    }
    else if ([_record isEqualToArray:records] == NO)
    {
        _record = [records mutableCopy];
    }
    [_delegate dataHasChanged:_record];
}


#pragma mark -
#pragma mark method
- (Record* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath{
     return self.records[indexPath.row];
}

- (void)update: (NSArray<Record*>* _Nullable)records{
    self.records = records;
}

- (NSUInteger)numberOfRecords{
    return [_record count];
}

@end
