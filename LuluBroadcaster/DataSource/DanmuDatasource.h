//
//  DanmuDatasource.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Danmu.h"

@protocol DanmuDatasourceDelegate <NSObject>
- (void)dataHasChanged: (NSArray<Danmu*>* _Nonnull) danmus;
@end

@interface DanmuDatasource : NSObject
@property (nonatomic, strong, nonnull) NSArray<Danmu*>* danmus;
@property (nonatomic, weak, nullable) id<DanmuDatasourceDelegate> delegate;

- (void)appendDanmu: (Danmu* _Nonnull)danmu;
- (NSInteger)numOfRows;
- (Danmu* _Nonnull) getModelAtIndexPath: (NSIndexPath* _Nonnull) indexPath;
- (void)update: (NSArray<Danmu*>* _Nullable)danmus;

@end
