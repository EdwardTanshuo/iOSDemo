//
//  UserDataSource.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol UserDatasourceDelegate <NSObject>
- (void)dataHasChanged: (NSArray<User*>* _Nonnull) users;
@end

@interface UserDataSource : NSObject
@property (nonatomic, strong, nonnull) NSArray<User*>* users;
@property (nonatomic, weak, nullable) id<UserDatasourceDelegate> delegate;

- (void)addUser: (User* _Nonnull)user;
- (void)removeUser: (User* _Nonnull)user;
- (User* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath;
- (void)update: (NSArray<User*>* _Nullable)users;

@end
