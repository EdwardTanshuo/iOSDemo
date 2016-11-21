//
//  Transaction.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Transaction : NSObject
@property (nonatomic, strong, nonnull) NSString* type;
@property (nonatomic, strong, nonnull) NSString* tid;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, strong, nullable) User* issuer;
@property (nonatomic, strong, nonnull) NSDate* date;

+ (Transaction* _Nonnull)transWithJSON:(id _Nonnull)data;
@end
