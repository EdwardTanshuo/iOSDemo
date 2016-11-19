//
//  DanmuSocket.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "DanmuSocket.h"
#import "UserSession.h"

@implementation DanmuSocket
- (instancetype)init{
    return [super init];
}

#pragma mark singleton
+ (DanmuSocket* _Nullable)sharedSocket {
    static DanmuSocket *sharedMySocket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMySocket = [[self alloc] init];
    });
    return sharedMySocket;
}

- (void)setupListener{
    __weak DanmuSocket* wself = self;
    
    //链接事件
    [self.socket on:@"connect" callback:^(NSArray * _Nonnull datas, SocketAckEmitter * _Nonnull emitter) {
        self.connected = YES;
        UserSession* session = [[UserSession alloc] init];
        [self authWithRoom:session.currentBroadcaster.room WithPassword:session.currentBroadcaster.danmuPassword];
    }];
    //断开事件
    [self.socket on:@"disconnect" callback:^(NSArray * _Nonnull datas, SocketAckEmitter * _Nonnull emitter) {
        self.connected = NO;
    }];
    //获取消息
    [self.socket on:@"danmu" callback:^(NSArray * _Nonnull datas, SocketAckEmitter * _Nonnull emitter) {
        if([datas count] > 0){
            NSArray* array = datas[0][@"data"];
            for(id danmu_json in array){
                if(danmu_json[@"username"] && danmu_json[@"text"] && [danmu_json[@"username"] isKindOfClass:[NSString class]] && [danmu_json[@"text"] isKindOfClass:[NSString class]]){
                    Danmu* danmu = [[Danmu alloc] initWithUser:(NSString*)(danmu_json[@"username"]) WithMessage:(NSString*)(danmu_json[@"text"])];
                    [_delegate hasRecievedDanmu:danmu];
                }
            }
        }
    }];
    //授权成功
    [self.socket on:@"connected" callback:^(NSArray * _Nonnull datas, SocketAckEmitter * _Nonnull emitter) {
        if([datas count] > 0){
            NSLog(@"%@", datas[0]);
        }
    }];
    //授权失败
    [self.socket on:@"init_error" callback:^(NSArray * _Nonnull datas, SocketAckEmitter * _Nonnull emitter) {
        if([datas count] > 0){
            NSLog(@"%@", datas[0]);
        }
    }];
    //弹幕发送错误
    [self.socket on:@"message_error" callback:^(NSArray * _Nonnull datas, SocketAckEmitter * _Nonnull emitter) {
        if([datas count] > 0){
            NSLog(@"%@", datas[0]);
        }
    }];
}

#pragma mark
#pragma mark actions
- (void)authWithRoom: (NSString* _Nonnull)room WithPassword: (NSString* _Nonnull)pass{
    [self.socket emit:@"authentication" withItems:@[@{@"room":room, @"password":pass}]];
}


@end
