//
//  BroadcasterDatasource.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/17/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "BroadcasterDatasource.h"

@interface BroadcasterDatasource (){
    NSMutableArray *_broadcasters;
}

@end

@implementation BroadcasterDatasource
@synthesize broadcasters = _broadcasters;

#pragma mark -
#pragma mark getter/setter
- (NSArray *)broadcasters
{
    if(!_broadcasters){
        _broadcasters = [NSMutableArray arrayWithArray:@[]];
    }
    return [_broadcasters copy];
}

- (void)setBroadcasters:(NSArray *)broadcasters
{
    if(!broadcasters){
        _broadcasters = [NSMutableArray arrayWithArray:@[]];
    }
    else if ([_broadcasters isEqualToArray:broadcasters] == NO)
    {
        _broadcasters = [broadcasters mutableCopy];
    }
    [_delegate dataHasChanged:_broadcasters];
}

#pragma mark -
#pragma mark methods
- (void)update: (NSArray<Broadcaster*>* _Nullable)broadcasters{
    self.broadcasters = broadcasters;
}

- (Broadcaster* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath{
    if([_broadcasters objectAtIndex:indexPath.row]){
        return _broadcasters[indexPath.row];
    }
    else{
        return nil;
    }
}

- (NSInteger)numOfRows{
    return [_broadcasters count];
}

@end
