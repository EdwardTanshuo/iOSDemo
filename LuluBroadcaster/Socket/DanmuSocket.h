//
//  DanmuSocket.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LuluSocket.h"
#import "Danmu.h"

@protocol DanmuSocketDelegate
- (void)hasRecievedDanmu: (Danmu* _Nonnull)danmu;
@end

@interface DanmuSocket : LuluSocket
@property (nonatomic, weak, nullable) id<DanmuSocketDelegate> delegate;
#pragma mark singleton
+ (DanmuSocket* _Nullable)sharedSocket;
@end
