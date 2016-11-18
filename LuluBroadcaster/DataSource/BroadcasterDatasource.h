//
//  BroadcasterDatasource.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/17/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Broadcaster.h"

@protocol BroadcasterDatasourceDelegate <NSObject>
- (void)dataHasChanged: (NSArray<Broadcaster*>* _Nonnull) broadcasters;
@end

@interface BroadcasterDatasource : NSObject
@property (nonatomic, strong, nonnull) NSArray<Broadcaster*>* broadcasters;
@property (nonatomic, weak, nullable) id<BroadcasterDatasourceDelegate> delegate;

- (void)update: (NSArray<Broadcaster*>* _Nullable)broadcasters;
- (Broadcaster* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath;
- (NSInteger)numOfRows;
@end
