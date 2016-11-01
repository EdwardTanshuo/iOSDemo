//
//  INSCameraAccessory.h
//  INSNanoSDKApp
//
//  Created by pengwx on 4/28/16.
//  Copyright © 2016 com.insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "INSCameraDef.h"


typedef NS_ENUM(NSUInteger, INSCameraAccessoryErrorCodeType){
    //打开tunel服务失败
    //Failed to open tunel service
    INSCameraAccessoryErrorCodeTypeOpenTunel,
};


@protocol INSCameraAccessoryDelegate <NSObject>

//相机配件错误
//Camera accessory error
- (void)cameraAccessoryOnError:(NSError *)error withDic:(NSDictionary *)dic;

@end



@interface INSCameraAccessory : NSObject


/**
 *  获取全局唯一INSCameraAccessory实例
 *  @return 全局唯一INSCameraAccessory实例
 
 * Globally INSCameraAccessory singleton instance
 * @return Globally INSCameraAccessory singleton instance
 */
+ (INSCameraAccessory*) defaultCamera;

/**
 *  打开相机配件
 此函数用作初始化连接nano相机的资源，如果nano相机连接到了ios系统，则会返回EAAccessory值，否则返回nil
 调用了此函数，在不再使用相机后，需要调用closeCamera来释放资源
 *  @return 如果有nano相机连接到IOS系统，将返回nano的EAAccessory值, 否则返回nil
 
 * Open the camera accessory
   This function is designed to initialize the connected nano camera resources. If the nano camera is connected to the iOS device, it will return EAAccessory value, otherwise return nil
   If you called this function, you have to call `closeCamera` to release resources when the camera is no longer in use,
   * @return If the nano camera is connected to the iOS device, it will return EAAccessory value, otherwise return nil
 */
- (EAAccessory*) openCamera;

/**
 *  关闭相机配件，释放资源
 *  Close camera accessory and release resources
 */
- (void) closeCamera;


//相机连接状态
//camera connection status
@property (atomic, readonly) INSConnectStatus status;
//相机配件
//camrea accessory
@property(nonatomic, strong, readonly) EAAccessory *accessory;
//相机配件delegate
//camera accessory delegate
@property(nonatomic, weak) id<INSCameraAccessoryDelegate> delegate;

@end
