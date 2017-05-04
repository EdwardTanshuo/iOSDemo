//
//  FollowerDatasource.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/10/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "FollowerDatasource.h"

@interface FollowerDatasource(){
    NSMutableArray *_followers;
}

@end

@implementation FollowerDatasource
@synthesize followers = _followers;

#pragma mark -
#pragma mark getter/setter
- (NSArray *)followers
{
    if(!_followers){
        _followers = [NSMutableArray arrayWithArray:@[]];
    }
    return [_followers copy];
}

- (void)setFollowers:(NSArray *)followers
{
    if(!followers){
        _followers = [NSMutableArray arrayWithArray:@[]];
    }
    else if ([_followers isEqualToArray:followers] == NO)
    {
        _followers = [followers mutableCopy];
    }
    [_delegate dataHasChanged:_followers];
}

#pragma mark -
#pragma mark method
- (User* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath{
    return self.followers[indexPath.item];
}

- (void)update: (NSArray<User*>* _Nullable)followers{
    self.followers = followers;
}

- (NSUInteger)numberOfFollowers{
    return [self.followers count];
}
@end
