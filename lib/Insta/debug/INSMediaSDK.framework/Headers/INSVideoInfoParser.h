//
//  INSVideoInfoParser.h
//  INSMediaApp
//
//  Created by jerett on 16/6/17.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>
#import "INSRenderType.h"
#import "INSMediaGPS.h"
#import "INSExtraInfo.h"

typedef enum : NSUInteger {
    /**
     *  未知的图片类型
     */
    INSVideoOffsetUnknown,
    /**
     *  第一代4K相机
     */
    INSVideoOffset4KV1,
    /**
     *  nano的V1版本
     */
    INSVideoOffsetNanoV1,
    
    /**
     *  nano的V2版本
     */
    INSVideoOffsetNanoV2,
} INSVideoOffsetVersion;


@interface INSVideoInfoParser : NSObject


-(instancetype)initWithURL:(NSURL*)URL;

/**
 *  异步打开媒体，对于网络数据可能需要很长时间
 *
 *  @param successBlock 打开成功后回调，发生在global线程
 *  @param errorBlock   失败回调，回调在global线程
 */
-(void)openOnSuccess:(dispatch_block_t)successBlock onError:(dispatch_block_t)errorBlock;

/**
 *  同步打开媒体，会阻塞线程
 *
 *  @return 是否成功
 */
-(BOOL)open;

/**
 *  异步截图，调用者需要记得手动释放内存
 *
 *  @param position     截图的时间
 *  @param successBlock 成功回调
 *  @param errorBlock   失败互调
 */
-(void)screenShotAt:(double)position onSuccess:(void(^)(CVPixelBufferRef))successBlock onError:(dispatch_block_t)errorBlock;

/**
 *  同步截图，调用者需要记得手动释放内存
 *
 *  @param position 截图的时间
 *
 *  @return 截图
 */
-(CVPixelBufferRef)screenShotAt:(double)position;

/**
 *  传入key获得value
 *
 *  @param key
 *
 *  @return value
 */
-(NSString*)getMetadata:(NSString*)key;


@property (nonatomic, assign, readonly) NSInteger width;
@property (nonatomic, assign, readonly) NSInteger height;
@property (nonatomic, assign, readonly) double duration;
@property (nonatomic, assign, readonly) double framerate;
@property (nonatomic, strong, readonly) NSString *offset;
@property (nonatomic, assign, readonly) INSVideoOffsetVersion videoOffsetVersion;

/**
 *  猜测的渲染类型
 *
 *  @return 应该渲染的类型,目前支持区分双球和全景
 */
@property (nonatomic, assign, readonly) INSRenderType supposedRenderType;

/**
 *  拓展信息，修改滤镜信息使用改变量
 */
@property (nonatomic, strong, readonly) INSExtraInfo *extraInfo;

/**
 *  序列号
 */
@property (nonatomic, strong) NSString *serialNumber;

/**
 *  获得gps数据
 *
 *  @return 是否获得到GPS数据,没有返回nil
 */
@property (nonatomic, strong, readonly) INSMediaGps *gpsData;


/**
 *  更新本地文件的滤镜信息
 *
 *  @return 是否更新成功
 */
-(BOOL)updateLocalFileExtraInfo;

@end
