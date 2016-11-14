//
//  CameraManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "CameraManager.h"
#import <INSNanoSDK/INSNanoSDK.h>
#import "LiveManager.h"
#import <NSLogger/NSLogger.h>
@interface CameraManager()

@end

@implementation CameraManager
#pragma mark singleton
+ (CameraManager*)sharedManager {
    static CameraManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.status = CameraStatusDisconnected;
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
                _status = CameraStatusDisconnected;
                [_delegate cameraDidDisconnect: self];
                break;
            case INSConnectStatusConnecting:
                _status = CameraStatusConnecting;
                [_delegate cameraIsConnecting: self];
                break;
            case INSConnectStatusConnected:
                 _status = CameraStatusConnected;
                [_delegate cameraDidConnect: self];
                break;
            case INSConnectStatusError:
                _status = CameraStatusDisconnected;
                [_delegate cameraConnectFail: self];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark methods
- (void)openCamera{
    LogMessage(@"camera", 1, @"pre-opene");
    [[INSCameraAccessory defaultCamera] openCamera];
 
    LogMessage(@"camera", 1, @"opened");
}

- (void)closeCamera{
     [[INSCameraAccessory defaultCamera] closeCamera];
    
}
@end
