//
//  HistoryDatasource.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Broad.h"

@protocol HistoryDatasourceDelegate <NSObject>
- (void)dataHasChanged: (NSArray<Broad*>* _Nonnull) histories;
- (void)dataHasFailed: (NSError*)error;
@end


@interface HistoryDatasource : NSObject
@property (nonatomic, strong, nonnull) NSArray<Broad*>* histories;
@property (nonatomic, weak, nullable) id<HistoryDatasourceDelegate> delegate;
@property (nonatomic, assign) NSInteger total;
- (void)fetchNew;
- (void)reset;
- (NSInteger)numOfRows;
- (Broad* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath;
@end
