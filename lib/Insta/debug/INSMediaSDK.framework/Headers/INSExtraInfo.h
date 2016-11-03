//
//  INSMediaExtraInfo.h
//  INSMediaApp
//
//  Created by jerett on 16/8/11.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "INSExtraJsonInfo.h"

@class INSExtraJsonInfo;
@interface INSExtraInfo : NSObject

/**
 *  使用extraInfo数据来初始化对象
 *  @param data extraInfo数据
 *  @return 如果data数据是一个完整的extrainfo数据，返回实例对象，否则返回nil
 */
- (instancetype) initWithExtraInfoData:(NSData*)data;

/**
 *  使用jsonInfo对象来初始化对象
 *  @param jsonInfo json数据
 *  @return 对象实例
 */
//- (instancetype) initWithJsonInfo:(INSExtraJsonInfo*)jsonInfo;

/**
 *  获取image扩展数据的长度，包括uuid等
 *  @param data 文件的尾部数据，必须不小于40个字节
 *  @return 如果成功则返回整个extraInfo的长度，否则返回-1
 */
+ (int) getImageExtraInfoLen:(NSData*)data;

/**
 *  获取video扩展数据的长度，包括uuid等
 *  @param data 文件的尾部数据，必须不小于40个字节
 *  @return 如果成功则返回整个extraInfo的长度，否则返回-1
 */
+ (int) getVideoExtraInfoLen:(NSData*)data;

/**
 *  版本
 */
@property (nonatomic) int version;

/**
 *  json数据, 可以为nil
 */
@property (nonatomic, strong) INSExtraJsonInfo *jsonInfo;

/**
 *  扩展数据
 */
@property (nonatomic, strong, readonly) NSData *extraData;

@end
