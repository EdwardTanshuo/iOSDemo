//
//  CardValue.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardValue : NSObject
@property (nonatomic, assign) BOOL                  busted;
@property (nonatomic, assign) NSInteger             value;

+ (CardValue* _Nonnull) valueWithJSON:(id _Nonnull)data;
@end
