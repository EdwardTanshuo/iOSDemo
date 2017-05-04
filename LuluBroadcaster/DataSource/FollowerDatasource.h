//
//  FollowerDatasource.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/10/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@protocol FollowerDatasourceDelegate <NSObject>
- (void)dataHasChanged: (NSArray<User*>* _Nonnull) followers;
@end

@interface FollowerDatasource : NSObject
@property (nonatomic, strong, nonnull) NSArray<User*>*                  followers;
@property (nonatomic, weak, nullable) id<FollowerDatasourceDelegate>    delegate;

- (User* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath;
- (void)update: (NSArray<User*>* _Nullable)followers;
- (NSUInteger)numberOfFollowers;

@end
