//
//  SceneDatasource.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.h"

@protocol SceneDatasourceDelegate <NSObject>
- (void)dataHasChanged: (NSArray<Record*>* _Nonnull) records;
@end

@interface SceneDatasource : NSObject
@property (nonatomic, strong, nonnull) NSArray<Record*>*             records;
@property (nonatomic, weak, nullable) id<SceneDatasourceDelegate>    delegate;

- (Record* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath;
- (void)update: (NSArray<Record*>* _Nullable)records;
- (NSUInteger)numberOfRecords;
@end
