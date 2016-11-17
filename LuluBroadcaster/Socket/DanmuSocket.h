//
//  DanmuSocket.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LuluSocket.h"

@interface DanmuSocket : LuluSocket
#pragma mark singleton
+ (DanmuSocket* _Nullable)sharedSocket;
@end
