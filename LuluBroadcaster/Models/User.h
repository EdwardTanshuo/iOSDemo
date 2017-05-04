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
@property (nonatomic, strong, nonnull) NSString* intimacy;
@property (nonatomic, strong, nonnull) NSString* sex;
@property (nonatomic, strong, nonnull) NSString* level;

+ (User* _Nonnull) userWithJSON:(id _Nonnull)data;
+ (User* _Nonnull) followerWithJSON:(id _Nonnull)data;
@end
