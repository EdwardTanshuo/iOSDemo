//
//  INSLensOffset.h
//  INSVideoPlayApp
//
//  Created by pwx on 7/12/15.
//  Copyright © 2015年 insta360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface INSLensOffset : NSObject

- (instancetype) initWithOffset:(NSString*)offset;

//获取镜头
- (NSArray*) getLens;

/**
 *  与offset比较是否相等
 *  @param offset offset值
 *  @param diff   比较差值，在此范围内float类型看做相等
 *  @return offset有效且相等返回YES，无效或不等返回NO
 */
- (BOOL) isEqualOffset:(NSString*)offset diff:(float)diff;


/**
 *  监测offset是否有效
 *  @param offset 相机offset
 *  @return 有效offset返回YES，无效返回NO
 */
+ (BOOL) isValidOffset:(NSString*)offset;

/**
 *  比较offset1和offset2参数是否相等
 *  @param offset1 offset1值
 *  @param offset2 offset2值
 *  @param diff    比较差值，在此范围内float类型看做相等
 *  @return offset有效且相等返回YES，无效或不等返回NO
 */
+ (BOOL) compareOffset:(NSString*)offset1 another:(NSString*)offset2 diff:(float)diff;


@property (nonatomic) BOOL isValid;                     //判断镜头是否有效
@property (nonatomic, assign) int fisheyeClipAngle;     //镜头融合使用的剪切角
@property (nonatomic, assign) int lenVersion;           //镜头版本信息
@property (nonatomic, assign) int offsetVersion;        //offset版本信息



@end

