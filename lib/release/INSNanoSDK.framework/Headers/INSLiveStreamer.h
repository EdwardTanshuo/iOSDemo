//
//  INSLiveStreamer.h
//  INSCamera
//
//  Created by jerett on 15/12/24.
//  Copyright © 2015年 insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <INSMediaSDK/INSRenderView.h>


@protocol INSLiveStreamer;

@protocol INSLiveStreamerStateDelegate <NSObject>

/**
 直播发生错误
 @param streamer 直播流处理对象
 @param error    错误
 
 Live error occurres
 @param streamer   object of the live stream processing
 @param error   error
 */
- (void)streamer:(id<INSLiveStreamer>)streamer onError:(NSError*)error;
/**
 直播开始
 @param streamer 直播流处理对象
 
 Live start
 @param streamer object of the live stream processing
 */
- (void)streamerOnStart:(id<INSLiveStreamer>)streamer;
/**
 直播停止
 @param streamer 直播流处理对象
 
 Live end
 @param streamer object of the live stream processing
 */
- (void)streamerOnStop:(id<INSLiveStreamer>)streamer;

@optional

/**
 直播流的fps与duration
 实现函数后，对象每隔一段时间会收到fps与duration的值
 @param fps      fps值
 @param duration 直播持续时间, 单位：秒
 
 The live stream's fps and duration
 After the implementation of the function, the object will receive the fps and duration value in interval
 @param fps The fps value
 @param duration live duration, unit:seconds
 */
- (void)streamerOnLiveFps:(double)fps duration:(double)duration;

@end



@protocol INSLiveStreamer <NSObject>

/**
 开始直播，同时观看相机的预览流，性能影响较大，不建议使用
 @param frame 预览视图的frame值
 @param block preview为预览相机视频流的view
 
 Start Live, and open the camera preview stream, a greater impact on performance(This method is not recommended)
 @param frame the frame value of preview
 @param block preview parameter is a view for previewing camera's video stream
 */
-(void)startLiveWithPreviewFrame:(CGRect)frame view:(void(^)(INSRenderView *preview))block;

/**
 开始直播，同步返回，状态必须为ready才能开始直播
 使用完成后，需要调用stopLive函数释放资源
 
 Start Live, Sync callback, status must be ready to start a live
 After use, you need to call the `stopLive` function to release the resource
 */
- (void)startLive;

/**
 停止向服务器串流，状态处理直播中调用,与startLive配对使用，释放资源
 
 Stop pushing stream data to server, called on Live , opposite to startLive, it will release resources
 */
- (void)stopLive;

/**
 直播状态delegate
 
 Live status delegate

 */
@property (nonatomic, weak) id<INSLiveStreamerStateDelegate> stateDelegate;

@end

