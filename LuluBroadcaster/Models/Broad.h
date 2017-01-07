//
//  Broad.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/19/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Broad : NSObject
@property(nonatomic, nonnull, strong) NSString* bid;
@property(nonatomic, nonnull, strong) NSDate* start;
@property(nonatomic, nonnull, strong) NSDate* end;
@property(nonatomic, assign) NSInteger value;

+ (Broad* _Nonnull)broadWithJSON:(id _Nonnull)data;
@end
