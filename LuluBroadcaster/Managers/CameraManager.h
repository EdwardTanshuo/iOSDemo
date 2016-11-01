//
//  CameraManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol CameraManagerDelegate
- (void) cameraDidDisconnect;
- (void) cameraDidConnect;
- (void) cameraIsConnecting;
- (void) cameraConnectFail;
@end

@interface CameraManager : NSObject

@property (nonatomic, weak) id<CameraManagerDelegate> delegate;

#pragma mark singleton
+ (id)sharedManager;

#pragma mark methods
- (void)openCamera;
- (void)closeCamera;
@end
