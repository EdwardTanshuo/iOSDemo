//
//  INSLiveDataSource.h
//  INSNanoSDKApp
//
//  Created by jerett on 16/6/14.
//  Copyright © 2016年 com.insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "INSCameraVideoResType.h"
#import <INSMediaSDK/INSMediaSDK.h>


typedef NS_ENUM(NSUInteger,  INSLiveErrorCodeType){
    //连接错误
    //Failed to Connect
    INSLiveErrorCodeTypeConnect,
    
    //解码相机数据流错误
    //Failed to Decode camera streaming data
    INSLiveErrorCodeTypeCameraDemux,
    
    //发送数据帧错误
    //Failed to Send frame data
    INSLiveErrorCodeTypeSendFrame,
    
    //获取相机offset错误
    //Failed to get camera offset
    INSLiveErrorCodeTypeGetOffset,
    
    //开启相机预览错误
    //Failed to open camera preview
    INSLiveErrorCodeTypeOpenCameraStream,
    
    //关闭相机预览错误
    //Failed to close camera preview
    INSLiveErrorCodeTypeStopCameraStream,
    
    //切换AACType失败
    //Failed to switch AACType
    INSLiveErrorCodeTypeSwitchAudioStream,
    
    //编码数据错误
    //Failed to encode data
    INSLiveErrorCodeTypeEncode,
};



@class INSLiveDataSource;

@protocol INSLiveDataSourceProtocol <NSObject>

/**
 发生错误
 @param error 错误code为INSLiveErrorCodeType
 
 An error occurred
 @param error The error code is INSLiveErrorCodeType
 */
-(void)sourceOnError:(NSError*)error;
/**
 拼接后视频流编码的sps，pps
 @param sps     sps数据指针
 @param spsSize sps数据大小
 @param pps     pps数据指针
 @param ppsSize pps数据大小
 
 Encode stitched video stream's sps, pps
 @param sps sps data pointer
 @param spsSize the size of sps data
 @param pps pps data pointer
 @param ppsSize the size of pps data
 */
-(void)sourceOnH264Header:(const uint8_t*)sps spsSize:(size_t)spsSize pps:(const uint8_t*)pps ppsSize:(size_t)ppsSize;
/**
 拼接后视频流编码的h264 nalu
 @param nalu      nalu数据，nalu数据的前四个字节为00 00 00 01
 @param size      nalu数据大小
 @param isKey     是否为关键帧
 @param timestamp 时间戳, 单位：毫秒
 
 After stitching the video stream's h264 nalu
 @param nalu nalu data, the first four bytes of nalu data are 00 00 00 01
 @param size the size of nalu data
 @param isKey Whether it's the key frame
 @param timestamp timestamp, unit:milliseconds
 */
-(void)sourceOnH264Nalu:(const uint8_t*)nalu size:(size_t)size keyFrame:(BOOL)isKey timestamp:(int64_t)timestamp ;
/**
 aac头部
 @param aacHeader  aac头指针
 @param headerSize aac头大小
 
 aac head
 @param aacHeader  aac head point
 @param headerSize aac head size

 */
-(void)sourceOnAACHeader:(const uint8_t*)aacHeader size:(size_t)headerSize;
/**
 aac数据
 @param aacData   aac数据
 @param size      aac数据大小
 @param timestamp 时间戳, 单位：毫秒
 
 aac data
 @param aacData   aac data
 @param size      the size of aac data
 @param timestamp timestamp, unit:milliseconds

 */
-(void)sourceOnAACData:(const uint8_t*)aacData size:(size_t)size timestamp:(int64_t)timestamp;

@optional

/**
 *  回调拼接好的数据
 *  @param pixelBuffer 拼接好的图片, BGRA格式
 *  @param timestamp 时间戳, 单位：毫秒
 
 * Callback stitched data 
 * @ Param pixelBuffer stitched image, BGRA format
 * @ Param timestamp   timestamp, unit:milliseconds
 */
-(void)sourceOnStitchPixelBuffer:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp;
/**
 *  回调相机原始数据
 *  @param pixelBuffer 回调相机原始数据 NV12格式
 *  @param timestamp 时间戳, 单位：毫秒

 
 * Callback camera raw data
 * @param pixelBuffer callback camera raw data in NV12 format
 * @ Param timestamp   timestamp, unit:milliseconds
 */
-(void)sourceOnRawPixelBuffer:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp;

@end


/**
 直播数据源对象
 通过此对象可以获取直播过程中各种音视频数据
 
 The Live data source object
 Various audio and video data during the Live can be obtained via this object
 */
@interface INSLiveDataSource : NSObject

/**
 初始化函数
 @param resolution 相机原始视频流的参数（分辨率，帧率）
 @param width      拼接后输出的画面宽度
 @param height     拼接后输出的画面高度
 @param bitrate    码率
 @return 实例对象
 
 initialization function
 @param resolution  Camera raw video stream parameters (resolution, frame rate)
 @param width       The width of the output after stitching
 @param height      The height of the output after stitching
 @param bitrate     bitrate
 @return            instance object
 */
-(instancetype)initWitCameraResolution:(INSCameraVideoResType)resolution stitchWidth:(NSUInteger)width stitchHeight:(NSUInteger)height bitrate:(NSUInteger)bitrate;

@property (nonatomic, weak) id<INSLiveDataSourceProtocol> dataSourceDelegate;

//拼接后视频图像的宽度
//The width of the stitched video image
@property (nonatomic, assign, readonly) NSUInteger width;

//拼接后视频图像的高度
//The height of the stitched video image
@property (nonatomic, assign, readonly) NSUInteger height;

//拼接后视频流的编码码率
//The bitrate of the video stream after stitching
@property (nonatomic, assign, readonly) NSUInteger bitrate;

//视频流的帧率，与初始化函数传入的resolution参数有关
//The frame rate of the video stream, which is related to the resolution parameter passed into the initialization function
@property (nonatomic, assign, readonly) NSUInteger fps;

/**
 是否对原始图像进行拼接
 当设置为NO的时候，表示不对原始图像拼接，并且此时会忽略isEncode的设置，不对图像进行编码输出
 
 Whether stitch the original image
 If set to NO, it won't stitch the original image, and will ignore the isEncode settings, and will not output the encoded image
 */
@property (nonatomic) BOOL isStitch;
/**
 是否对图像进行编码输出
 当isRender设置为NO时，设置值被忽略，不会对图像进行编码输出
 
 Whether output the encoded image
 When isRender is set to NO, the set value will ignored and do not output the encoded image
 */
@property (nonatomic) BOOL isEncode;

/**
 开始直播，同时观看相机的预览流，性能影响较大，不建议使用
 @param frame 预览视图的frame值
 @param block preview为预览相机视频流的view
 
 Start Live, and open the camera preview stream, a greater impact on performance(This method is not recommended)
 @param frame the frame value of preview
 @param block preview parameter is a view for previewing camera's video stream
 */
-(void)startWithPreviewFrame:(CGRect)frame view:(void(^)(INSRenderView *preview))block;

/**
 开始，创建资源，当使用完成后需要调用stop函数释放资源
 
 Start operation, will create a resource. you have to call 'stop' function to release resources after using
 */
-(void)start;

/**
 停止，与start函数配对使用，释放资源
 
 Stop operation, opposite to the `start` function, to release resources
 */
-(void)stop;

@end
