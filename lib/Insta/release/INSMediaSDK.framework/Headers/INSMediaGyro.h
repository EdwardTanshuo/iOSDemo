//
//  INSMediaGyro.h
//  INSMediaApp
//
//  Created by pengwx on 16/8/10.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INSMotionData.h"



@interface INSMediaGyro : NSObject

/**
 *  使用INSMediaGyroData来初始化对象
 *  @param gyro 陀螺仪数据
 *  @return 实例对象，如果gyro数据无效，则返回nil
 */
- (instancetype) initWithGyroData:(gyro_media_data)gyro;

/**
 *  使用CMDeviceMotion来初始化对象
 *  @param motion 运动数据
 *  @return 实例对象，如果motion数据无效，则返回nil
 */
- (instancetype) initWithCMDeviceMotion:(CMDeviceMotion*)motion;

/**
 *  使用json格式的NSDictionary初始化对象
 *  @param dic NSDictionary
 *  @return 成功返回对象，失败返回nil
 */
- (instancetype) initWithJsonDictionary:(NSDictionary*)dic;

/**
 *  获取对象的json格式的NSDictionary
 *  @return NSDictionary
 */
- (NSDictionary*)jsonDictionary;

/**
 *  获取由gyro数据转换成的四元数
 *  @return 四元数
 */
- (GLKQuaternion) getRotateQuaternion;

/**
 *  陀螺仪数据是否有效
 *  @return 有效返回YES，无效返回NO
 */
- (BOOL) isValid;

/**
 *  将系统的CMDeviceMotion数据转为自定义的INSMediaGyroData数据
 *  @param motion CMDeviceMotion 系统motion数据
 *  @return 转换后的INSMediaGyroData数据
 */
+ (gyro_media_data) gyroDataFromCMDeviceMotion:(CMDeviceMotion*)motion;


@property (nonatomic) double ax;
@property (nonatomic) double ay;
@property (nonatomic) double az;
@property (nonatomic) double gx;
@property (nonatomic) double gy;
@property (nonatomic) double gz;

@end
