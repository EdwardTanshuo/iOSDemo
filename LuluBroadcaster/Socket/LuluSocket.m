//
//  LuluSocket.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LuluSocket.h"


static inline NSURL* socket_url(){
    return [NSURL URLWithString:SOCKET_URL];
}

@interface LuluSocket()
@end

@implementation LuluSocket

#pragma mark
#pragma mark init
- (instancetype)init{
    _socket = [[SocketIOClient alloc] initWithSocketURL:socket_url() config:@{@"log": @YES, @"forcePolling": @YES}];
    _connected = NO;
    [self setupListener];
    return [super init];
}

- (void) setupListener{
   
}


#pragma mark
#pragma mark methods
- (BOOL)isConnected{
    if(_connected){
        return YES;
    }
    else{
        return NO;
    }
}

- (void)connect{
    if([self isConnected]){
        return;
    }
    [self.socket connect];
 }

- (void)disconnect{
    if(![self isConnected]){
        return;
    }
    [self.socket disconnect];
}
@end
