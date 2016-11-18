//
//  LuluSocket.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketIO/SocketIO-Swift.h>

#define SOCKET_URL @"ws://release.mofangvr.com:30001/?EIO=4&transport=websocket"

static inline NSURL* socket_url();

@interface LuluSocket : NSObject
@property (nonatomic, strong) SocketIOClient* socket;
@property (nonatomic, assign) BOOL connected;

- (void)setupListener;
- (BOOL)isConnected;
- (void)connect;
- (void)disconnect;

@end
