//
//  CameraManager.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CameraManager;

typedef NS_ENUM(NSInteger, CameraStatus) {
    CameraStatusConnected,
    CameraStatusConnecting,
    CameraStatusDisconnected
};

@protocol CameraManagerDelegate
- (void) cameraDidDisconnect:(CameraManager*) manager;
- (void) cameraDidConnect:(CameraManager*) manager;
- (void) cameraIsConnecting:(CameraManager*) manager;
- (void) cameraConnectFail:(CameraManager*) manager;
@end

@protocol GameStreamSyncDelegate
- (void) cameraDidDisconnect:(CameraManager*) manager;
@end

@interface CameraManager : NSObject

@property (nonatomic, weak) id<CameraManagerDelegate> delegate;
@property (nonatomic, weak) id<GameStreamSyncDelegate> syncDelegate;
@property (nonatomic, assign) enum CameraStatus status;

#pragma mark singleton
+ (CameraManager*)sharedManager;

#pragma mark methods
- (void)openCamera;
- (void)closeCamera;
@end
