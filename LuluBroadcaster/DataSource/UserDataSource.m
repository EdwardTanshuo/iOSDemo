//
//  UserDataSource.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "UserDataSource.h"

@interface UserDataSource(){
    NSMutableArray *_users;
}

@end

@implementation UserDataSource
@synthesize users = _users;

#pragma mark -
#pragma mark getter/setter
- (NSArray *)users
{
    if(!_users){
        _users = [NSMutableArray arrayWithArray:@[]];
    }
    return [_users copy];
}

- (void)setUsers:(NSArray *)users
{
    if(!users){
        _users = [NSMutableArray arrayWithArray:@[]];
    }
    else if ([_users isEqualToArray:users] == NO)
    {
        _users = [users mutableCopy];
    }
    [_delegate dataHasChanged:_users];
}

#pragma mark -
#pragma mark method
- (void)addUser: (User* _Nonnull)user{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid==%@", user.uid];
    NSArray *subArray = [_users filteredArrayUsingPredicate:predicate];
    if(!subArray || [subArray count] == 0){
        [_users insertObject:user atIndex:0];
    }
}

- (void)removeUser: (User* _Nonnull)user{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid==%@", user.uid];
    NSArray *results = [_users filteredArrayUsingPredicate:predicate];
    if(!results || [results count] == 0){
        return;
    }
    [_users removeObject:results[0]];
}

- (User* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath{
    return nil;
}

- (void)update: (NSArray<User*>* _Nullable)users{
    self.users = users;
}

@end
