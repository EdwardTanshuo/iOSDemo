//
//  Record.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject
@property(nonatomic, strong, nonnull) NSString* day;
@property(nonatomic, strong, nonnull) NSString* start_time;
@property(nonatomic, strong, nonnull) NSString* finish_time;
@property(nonatomic, assign)          NSInteger duration;

+ (Record* _Nonnull) recordWithJSON:(id _Nonnull)data;
@end
