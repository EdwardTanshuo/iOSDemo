//
//  INSImageInfoParser.h
//  INSMediaApp
//
//  Created by jerett on 16/6/17.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INSMediaGyro.h"
#import "INSMediaGps.h"
#import "INSExtraInfo.h"

typedef enum : NSUInteger {
    /**
     *  未知的图片类型
     */
    INSImageOffsetUnknown,
    /**
     *  第一代4K相机
     */
    INSImageOffset4kV1,
    /**
     *  nano的V1版本
     */
    INSImageOffsetNanoV1,
    /**
     *  nano的V2版本
     */
    INSImageOffsetNanoV2,
} INSImageOffsetVersion;

@interface INSImageInfoParser : NSObject

/**
 *  会下载URL的数据到NSData，如果是网络数据会堵塞
 *
 *  @param URL 图片URL，对于网络图片只读打开；对于本地文件对写打开，可以修改里面的滤镜等数据
 *
 *  @return 如果下载失败，返回nil
 */
-(instancetype)initWithURL:(NSURL*)URL;

/**
 *
 *  @param imgData 图像数据，只读打开
 *
 *  @return parser对象
 */
-(instancetype)initWithData:(NSData*)imgData;

-(BOOL)open;

-(NSString*)getMetadata:(NSString*)key;

/**
 *  图片的二进制数据
 */
@property (nonatomic, strong, readonly) NSData *imgData;

/**
 *  offst数据
 */
@property (nonatomic, strong, readonly) NSString *offset;

/**
 *  陀螺仪数据
 */
@property (nonatomic, strong) INSMediaGyro *gyroData;

/**
 *  gps数据
 */
@property (nonatomic, strong) INSMediaGps *gpsData;

/**
 *  序列号
 */
@property (nonatomic, strong) NSString *serialNumber;

/**
 *  图片的信息版本
 */
@property (nonatomic, assign, readonly) INSImageOffsetVersion imageOffsetVersion;

/**
 *  拓展信息，修改滤镜信息使用改变量
 */
@property (nonatomic, strong, readonly) INSExtraInfo *extraInfo;

/**
 *  更新本地文件的滤镜信息，参考initWithURL和initWithData的doc
 *
 *  @return 是否更新成功
 */
-(BOOL)updateLocalFileExtraInfo;


@end
