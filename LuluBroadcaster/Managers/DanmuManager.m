//
//  DanmuManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "DanmuManager.h"
#import "DanmuSocket.h"

@interface DanmuManager()<DanmuDatasourceDelegate, DanmuSocketDelegate>

@end

@implementation DanmuManager
#pragma mark singleton
+ (DanmuManager* _Nonnull)sharedManager {
    static DanmuManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init{
    self.datasource = [[DanmuDatasource alloc] init];
    self.datasource.delegate = self;
    [DanmuSocket sharedSocket].delegate = self;
    return [super init];
}

#pragma mark -
#pragma mark DanmuDatasourceDelegate
- (void)dataHasChanged:(NSArray<Danmu *> *)danmus{
    [self.delegate dataHasChanged:danmus];
}

- (void)sendDanmu: (Danmu* _Nonnull)danmu{
    [self.datasource appendDanmu:danmu];
}

- (void)cleanDanmu{
    self.datasource.danmus = @[];
}

#pragma mark -
#pragma mark DanmuSocketDelegate
- (void)hasRecievedDanmu:(Danmu *)danmu{
    [self sendDanmu:danmu];
}
@end

