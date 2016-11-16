//
//  UserSession.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject
#pragma mark public
@property (nonatomic, strong, readonly) NSString* userName;
@property (nonatomic, strong, readonly) NSString* password;
@property (nonatomic, strong, readonly) NSString* token;

#pragma mark methods
- (BOOL)hasToken;
- (void)saveSessionWithEmail:(NSString*)email WithPassword:(NSString*)password;
- (void)saveToken: (NSString*)token WithEmail:(NSString*)email;
@end
