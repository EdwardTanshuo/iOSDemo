//
//  SettingSession.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingSession : NSObject
#pragma mark public
@property (nonatomic, assign) NSUInteger bitrate;
@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, assign) NSUInteger height;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* streamKey;
@end
