//
//  INSFlatLiveStreamer.h
//  INSNanoSDKApp
//
//  Created by jerett on 16/5/25.
//  Copyright © 2016年 com.insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INSLiveStreamer.h"
#import "INSCameraVideoResType.h"


/**
 直播平铺的图像
 调用startLive会自己开启预览流，调用者无须使用其他的方法
 
 Stitched Live image
 Calling starLive operation will open the preview stream automaticlly, there's no need to call other methods
 */

@interface INSFlatLiveStreamer : NSObject <INSLiveStreamer>

/**
 初始化函数，当前支持rtmp协议
 @param url        rtmp服务器地址,形如rtmp://192.168.2.122/live/abc
 @param resolution 相机原始视频流的参数（分辨率，帧率）
 @param width      拼接后输出的画面宽度
 @param height     拼接后输出的画面高度
 @param bitrate    码率
 @return 实例对象
 
 Initialization, it supports rtmp agreement currently
   @Param url           rtmp server address, e.g. rtmp: //192.168.2.122/live/abc
   @param resolution    Camera raw video stream parameters (resolution, frame rate)
   @param width         The width of the output after stitching
   @param height        The height of the output after stitching
   @param bitrate       bitrate
   @return              instance
 */
-(instancetype)initWithRtmpAddress:(NSURL*)url cameraResolution:(INSCameraVideoResType)resolution stitchWidth:(NSUInteger)width stitchHeight:(NSUInteger)height bitrate:(NSUInteger)bitrate;


@end
