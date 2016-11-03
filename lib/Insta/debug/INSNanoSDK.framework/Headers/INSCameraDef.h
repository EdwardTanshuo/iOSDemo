 //
//  INSCameraDef.h
//  INSNanoSDKApp
//
//  Created by pengwx on 4/28/16.
//  Copyright © 2016 com.insta360. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  相机配件协议
 *  camera accessory protocol
 */
//相机协议
//camera protocol
#define Insta360CameraProtocol      @"com.insta360.camera"
//控制协议
//control protocol
#define Insta360ControlProtocal     @"com.insta360.control"


/**
 *  相机配件连接通知
 *  camera accessory connection notification
 */
//相机插入连接通知
//转发系统检测到相机插入时的通知，SDK在转发此通知前，会初始化session，建立socket监听，将相机连接置为INSConnectStatusConnecting，等操作
//Camera accessory connect notification
//Fowarding the connect notification when the iOS device detects a camera connection.
#define INSCameraDidConnectNotification        @"INSCameraDidConnectNotification"

//相机拔出断开通知
//转发系统检测到相机拔出断开时的通知，SDK在转发此通知后，会关闭session，释放socket监听，将相机连接状态置为INSConnectStatusDisconnect，等操作
//Camera accessory disconnect notification
//Fowarding the disconnect notification when the iOS device detects a camera disconnection.
#define INSCameraDidDisConnectNotification     @"INSCameraDidDisConnectNotification"

//以上两个通知使用的key值
//在属性userInfo中通过此key值，可取出相机配件:EAAccessory
//The key value used by the two notifications above
//You can use this key in "userInfo" to obtain the EAAccessory object.
#define INSCameraConnectAccessoryKey           @"INSCameraConnectAccessoryKey"



/**
 * 相机连接状态
 * camera connection status
 */
typedef NS_ENUM(NSUInteger, INSConnectStatus)
{
    //相机未连接, 系统未检测到相机插入
    //Camera not connected: the iOS system has not detected the camera.
    INSConnectStatusDisconnect,
    
    //相机连接中，相机相应了插入通知，SDK正在与相机建立数据连接
    //The camera is connecting: the iOS system detects the camera, but the SDK has not yet established a data connection with the camera.
    INSConnectStatusConnecting,
    
    //相机已经连接上，程序与相机建立起数据连接
    //The camera is connected: The SDK has established a data connection with the camera.
    INSConnectStatusConnected,
    
    //相机连接错误，出现此状态表示相机响应了插入通知，未响应拔出通知，但是在规定时间里面无法与程序建立数据连接
    //Camera connection error: the iOS system detects the camera, but the SDK can not establish a data connection with the camera in a specified time.
    INSConnectStatusError,
};



