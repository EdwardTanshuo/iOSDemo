//
//  INSRenderView.h
//  INSVideoPlayApp
//
//  Created by pwx on 20/2/16.
//  Copyright © 2016年 insta360. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "INSRenderType.h"


@protocol INSPlayerProtocol;
@class INSRender;
@class INSRenderManager;
@class INSVideoDisplayLink;
@class INSProjectionStrategy;



@interface INSRenderView : UIView


/**
 *  初始化函数
 *  @param frame  视图的frame
 *  @param layer  视图显示的CAEAGLLayer
 *  @param render 画面渲染器
 *  @return INSRenderView对象的实例
 */
- (instancetype) initWithFrame:(CGRect)frame layer:(CAEAGLLayer*)layer render:(INSRender*)render;

/**
 *  初始化函数
 *  @param frame      视图的fram
 *  @param renderType 使用render的类型
 *  @return INSRenderView对象的实例
 */
- (instancetype) initWithFrame:(CGRect)frame renderType:(INSRenderType)renderType;


/**
 *  播放视频流
 *  @param player 留播放器
 *  @param offset 拼接offset值
 */
- (void) playVideoStream:(id<INSPlayerProtocol>)player offset:(NSString*)offset;

/**
 *  播放图片
 *  @param image  图片
 *  @param offset 拼接offset值
 */
- (void) playImage:(UIImage*)image offset:(NSString*)offset;

/**
 *  播放图片
 *  此函数会强制绘制图片一次，但会调用stopDisplayLink，即不会以屏幕刷新率来同步绘制显示内容，如需与屏幕刷新率同步，需显式调用startDisplayLink；
 *  @param image  图片
 *  @param offset 拼接offset值
 */
- (void) playImageWithStopDisplayLink:(UIImage *)image offset:(NSString *)offset;

/**
 *  开始屏幕刷新
 */
- (void) startDisplayLink;

/**
 *  停止屏幕刷新
 */
- (void) stopDisplayLink;

/**
 *  画面展示模式，一般为INSViewPresentModeSingle，但对于部分render可能为其他值
 */
@property (nonatomic) INSViewPresentMode presentMode;

/**
 *  画面交互模式，默认INSInteractiveModeFinger
 */
@property (nonatomic) INSViewInteractiveMode interactiveMode;

/**
 *  画面投影观看模式，默认为INSViewProjectionModeFisheye
 *  使用INSViewProjectionModeCustom值设置此属性，属性值将不会改变
 */
@property (nonatomic) INSViewProjectionMode projectionMode;

/**
 *  陀螺仪模式下手势滑动方式，X，Y坐标体系为View的坐标体系
 *  属性interactiveMode=INSViewInteractiveModeFingerAndGyro时，此属性值起作用
 */
@property (nonatomic) INSGyroSlipType gyroSlipType;


@property (nonatomic, weak, readonly) id <INSPlayerProtocol> player;            //流播放器
@property (nonatomic, strong, readonly) INSRender *render;                      //画面渲染器
@property (nonatomic, strong, readonly) INSRenderManager *renderManager;        //渲染管理器，手势，陀螺仪处理
@property (nonatomic, strong, readonly) CAEAGLLayer *glLayer;                   //画面显示layer
@property (nonatomic, strong, readonly) INSVideoDisplayLink *displayLink;             //显示


@end
