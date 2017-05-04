//
//  BroadcasterModel.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/13/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Broadcaster : NSObject
@property (nonatomic, strong, nonnull) NSString* name;
@property (nonatomic, strong, nonnull) NSString* email;
@property (nonatomic, strong, nonnull) NSString* wowzaUri;
@property (nonatomic, strong, nonnull) NSString* wowzaLogin;
@property (nonatomic, strong, nonnull) NSString* wowzaPassword;
@property (nonatomic, strong, nonnull) NSString* profileImageURL;
@property (nonatomic, strong, nonnull) NSString* danmuPassword;
@property (nonatomic, strong, nonnull) NSString* room;
@property (nonatomic, strong, nonnull) NSString* bio;

@property (nonatomic, assign) NSInteger viewers_count;
@property (nonatomic, assign) NSInteger wealth;
@property (nonatomic, assign) NSInteger followers_count;

+ (Broadcaster* _Nonnull)broadcasterWithJSON:(id _Nonnull)data;
+ (Broadcaster* _Nonnull)broadcasterPHPWithJSON:(id _Nonnull)data;
@end
