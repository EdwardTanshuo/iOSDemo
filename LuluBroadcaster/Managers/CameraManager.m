//
//  CameraManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "CameraManager.h"
#import <INSNanoSDK/INSNanoSDK.h>

@interface CameraManager()

@end

@implementation CameraManager
#pragma mark singleton
+ (id)sharedManager {
    static CameraManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        [[INSCameraAccessory defaultCamera] addObserver:sharedMyManager forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    });
    return sharedMyManager;
}

- (void) dealloc{
    [[INSCameraAccessory defaultCamera] removeObserver:self forKeyPath:@"status"];
}

#pragma mark -
#pragma mark KVO
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString*,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        INSConnectStatus status = [[change valueForKey:NSKeyValueChangeNewKey] intValue];
        switch (status) {
            case INSConnectStatusDisconnect:
                [_delegate cameraDidDisconnect];
                break;
            case INSConnectStatusConnecting:
                [_delegate cameraIsConnecting];
                break;
            case INSConnectStatusConnected:
                [_delegate cameraDidConnect];
                break;
            case INSConnectStatusError:
                [_delegate cameraConnectFail];
                break;
            default:
                break;
        }
    }
}

#pragma mark methods
- (void)openCamera{
     [[INSCameraAccessory defaultCamera] openCamera];
}

- (void)closeCamera{
     [[INSCameraAccessory defaultCamera] closeCamera];
}
@end
