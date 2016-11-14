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
@property (nonatomic, strong, nonnull) NSString* bio;
@property (nonatomic, strong, nonnull) NSString* location;
@property (nonatomic, strong, nonnull) NSString* password;
@property (nonatomic, strong, nonnull) NSString* wowzaUri;
@property (nonatomic, strong, nonnull) NSString* wowzaLogin;
@property (nonatomic, strong, nonnull) NSString* wowzaPassword;
@property (nonatomic, strong, nonnull) NSString* profileImageURL;
@property (nonatomic, strong, nonnull) NSString* danmuPassword;

@end
