//
//  INSRenderManager.h
//  INSVideoPlayApp
//
//  Created by pwx on 24/2/16.
//  Copyright © 2016年 insta360. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "INSRenderType.h"

@class INSRender;

@interface INSRenderManager : NSObject

@property (nonatomic, strong) INSRender *render;          //图形渲染器

/**
 *  画面交互模式，默认INSInteractiveModeFinger
 */
@property (nonatomic) INSViewInteractiveMode interactiveMode;

/**
 *  陀螺仪模式下手势滑动方式，X，Y坐标体系为View的坐标体系
 *  属性interactiveMode=INSViewInteractiveModeFingerAndGyro时，此属性值起作用
 */
@property (nonatomic) INSGyroSlipType gyroSlipType;

/**
 *  陀螺仪暂停
 */
@property (nonatomic) BOOL gyroPause;

//初始化函数
- (instancetype) initWithRender:(INSRender*)render;

//准备渲染
- (void) prepareRender;

//设置陀螺仪的开始方位
- (void) setGyroOrientation:(UIInterfaceOrientation)gyroOrientation;

//开始惯性滑动
- (void) startInertialRotationWithVelocityX:(float)Vx velocityY:(float)Vy;

//停止惯性滑动
- (void) stopInertialRotation;

//通过屏幕移动点的距离来旋转模型
- (void) rotateObjectModelWithScreenPointMoveDistanceX:(float)dx distanceY:(float)dy;

@end
