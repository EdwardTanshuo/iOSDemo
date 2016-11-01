//
//  INSPlayer.h
//  INSMediaApp
//
//  Created by jerett on 16/6/3.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INSPlayerProtocol.h"

@interface INSPlayer : NSObject <INSPlayerProtocol>

@property (nonatomic, assign, readonly) BOOL useSystemPlayer;

@end
