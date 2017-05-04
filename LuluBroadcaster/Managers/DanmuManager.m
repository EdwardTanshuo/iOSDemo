//
//  DanmuManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/18/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "DanmuManager.h"
#import "GameManager.h"

@interface DanmuManager()<DanmuDatasourceDelegate, MessageEvent>

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
    [GameManager sharedManager].msgDelegate = self;
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
#pragma mark DanmuManagerDelegate
- (void)recievedanmu: (NSString* _Nullable)text WithUser: (NSString* _Nullable)user{
    Danmu* danmu = [[Danmu alloc] initWithUser:user WithMessage:text WithType:NormalDanmuType];
    [self sendDanmu:danmu];
}

- (void)recieveGift:(NSInteger)gid WithUser:(NSString *)user{
    NSArray* list = [[GameManager sharedManager] giftList];
    for(Gift* iter in list){
        if(iter.gid == gid){
            Danmu* danmu = [[Danmu alloc] initWithUser:user WithMessage:[NSString stringWithFormat:@"%@  价值: %ld", iter.name, (long)iter.cost] WithType:GiftDanmuType];
            [self sendDanmu:danmu];
            return;
        }
    }
}
@end

