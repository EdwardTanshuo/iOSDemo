//
//  DanmuDatasource.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "DanmuDatasource.h"
@interface DanmuDatasource (){
    NSMutableArray *_danmus;
}

@end

@implementation DanmuDatasource
@synthesize danmus = _danmus;
#pragma mark -
#pragma mark getter/setter
- (NSArray *)danmus
{
    if(!_danmus){
        _danmus = [NSMutableArray arrayWithArray:@[]];
    }
    return [_danmus copy];
}

- (void)setDanmus:(NSArray *)danmus
{
    if(!danmus){
        _danmus = [NSMutableArray arrayWithArray:@[]];
    }
    else if ([_danmus isEqualToArray:danmus] == NO)
    {
        _danmus = [danmus mutableCopy];
    }
    [_delegate dataHasChanged:_danmus];
}

#pragma mark -
#pragma mark method
- (void)appendDanmu: (Danmu* _Nonnull)danmu{
    if(!_danmus){
        self.danmus = @[];
    }
    [_danmus addObject:danmu];
    [_delegate dataHasChanged:_danmus];
}

- (NSInteger)numOfRows{
    return [_danmus count];
}

- (void)update: (NSArray<Danmu*>* _Nullable)danmus{
    self.danmus = danmus;
}

- (Danmu* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath{
    if([_danmus objectAtIndex:indexPath.row]){
        return _danmus[indexPath.row];
    }
    else{
        return nil;
    }
}
@end
