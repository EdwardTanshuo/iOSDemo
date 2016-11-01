//
//  INSSphericalOffscreenRender.h
//  INSMediaApp
//
//  Created by pengwx on 4/14/16.
//  Copyright © 2016 Insta360. All rights reserved.
//

#import "INSOffscreenRender.h"
#import "INSRenderType.h"

@class INSCamera;

/**
 球形离屏渲染器
 主要完成将输入图像渲染成在camera观察角度下的图像
 */

@interface INSSphericalOffscreenRender : INSOffscreenRender

/**
 *  以自定义投影方式初始化
 *  @param customProjection 自定义投影观看视图的参数值
 *  @param color            背景颜色
 *  @param width            渲染生成的图片的宽度
 *  @param height           渲染生成的图片的高度
 *  @return 完成初始化后的INSSphericalOffscreenRender对象
 */
- (instancetype) initWithCustomViewProjection:(INSCustomProjection)customProjection backgroundColor:(GLKVector3)color width:(int)width height:(int)height;

/**
 *  以小行星投影方式初始化
 *  @param width  渲染生成的图片的宽度
 *  @param height 渲染生成的图片的高度
 *  @return 完成初始化后的INSSphericalOffscreenRender对象
 */
- (instancetype) initAsteroidWithWidth:(int)width height:(int)height;

/**
 *  以圆形方式初始化
 *  @param width  渲染生成的图片的宽度
 *  @param height 渲染生成的图片的高度
 *  @return 完成初始化后的INSSphericalOffscreenRender对象
 */
- (instancetype) initCenterCircleWithWidth:(int)width height:(int)height;

/**
 *  以圆形方式初始化
 *  @param width   渲染生成的图片的宽度
 *  @param height  渲染生成的图片的高度
 *  @param minEdge 图形与左边缘或下边缘的最小距离
 *  @return 完成初始化后的INSSphericalOffscreenRender对象
 */
- (instancetype) initCenterCircleWithWidth:(int)width height:(int)height minEdge:(int)minEdge;


/**
 以圆形方式初始化
 @param width   渲染生成的图片的宽度
 @param height  渲染生成的图片的高度
 @param minEdge 图形与左边缘或下边缘的最小距离
 @param color   背景颜色
 @return 完成初始化后的INSSphericalOffscreenRender对象
 */
- (instancetype) initCenterCircleWithWidth:(int)width height:(int)height minEdge:(int)minEdge backgroundColor:(GLKVector3)color;

/**
 *  设置渲染生成图片的宽和高
 *  @param width  渲染生成的图片的宽度
 *  @param height 渲染生成的图片的高度
 */
- (void) setRenderWidth:(int)width height:(int)height;

/**
 *  交换镜头位置   默认值：NO
 *  设置此参数为YES，会使相机的方向反向
 */
@property (nonatomic) BOOL swapOrientation;


@end
