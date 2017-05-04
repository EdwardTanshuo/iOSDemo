//
//  DanmuManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DanmuDatasource.h"

@interface DanmuManager : NSObject
@property(nonatomic, weak, nullable) id<DanmuDatasourceDelegate> delegate;
@property(nonatomic, strong, nonnull) DanmuDatasource* datasource;
#pragma mark singleton
+ (DanmuManager* _Nonnull)sharedManager;
- (void)sendDanmu: (Danmu* _Nonnull)danmu;
- (void)cleanDanmu;

@end
