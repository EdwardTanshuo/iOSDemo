//
//  INSExtraJsonInfo.h
//  INSMediaApp
//
//  Created by pengwx on 16/8/5.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INSFilter.h"

@class INSMediaGps;
@class INSMediaGyro;
@class INSMediaOrientation;

@interface INSExtraJsonInfo : NSObject

/**
 *  使用json数据初始化各属性值
 *  @param data 扩展数据
 *  @return 实例对象，创建失败时返回nil
 */
- (instancetype) initWitJsonData:(NSData*)data;

/**
 *  获取扩展信息的json数据
 *  @return json数据
 */
- (NSData*) jsonData;

/**
 *  offset参数，可以为nil
 */
@property (nonatomic, copy) NSString *offset;

/**
 *  serialNumber参数，可以为nil
 */
@property (nonatomic, copy) NSString *serialNumber;

/**
 *  gps参数，可以为nil
 */
@property (nonatomic) INSMediaGps *gps;

/**
 *  gyro参数， 可以为nil
 */
@property (nonatomic) INSMediaGyro *gyro;

/**
 *  orientation参数， 可以为nil
 */
@property (nonatomic) INSMediaOrientation *orientation;

/**
 *  滤镜，无滤镜时返回 INSFilterTypeNull
 */
@property (nonatomic) INSFilterType filterType;

/**
 *  美颜滤镜，无滤镜时返回 INSFilterTypeNull
 */
@property (nonatomic) INSFilterType beautifyFilterType;

@end
