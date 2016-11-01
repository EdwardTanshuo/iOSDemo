//
//  INSMediaGps.h
//  INSMediaApp
//
//  Created by pengwx on 16/8/10.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface INSMediaGps : NSObject


- (instancetype) initWithLatitude:(double)latitude longitude:(double)longitude altitude:(double)alitude;

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

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) double altitude;

@end
