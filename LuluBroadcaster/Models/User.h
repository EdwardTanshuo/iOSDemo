//
//  User.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong, nonnull) NSString* avatar;
@property (nonatomic, strong, nonnull) NSString* name;
@property (nonatomic, strong, nonnull) NSString* uid;
@property (nonatomic, assign) NSInteger foreignId;

+ (User* _Nonnull) userWithJSON:(id _Nonnull)data;

@end
