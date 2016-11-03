//
//  INSOffscreenRender.h
//  INSMediaApp
//
//  Created by pengwx on 16/7/25.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@class INSFilter;

@interface INSOffscreenRender : NSObject{
}


/**
 *  设置渲染生成图片的宽和高
 *  @param width  渲染生成的图片的宽度
 *  @param height 渲染生成的图片的高度
 */
- (void) setRenderWidth:(int)width height:(int)height;

/**
 *  使用已经拼接好的Flat图片来进行渲染
 *  @param image 原始图片，已经拼接好的全景图片
 *  @return 渲染生成的图片，渲染失败返回nil
 */
- (UIImage*) renderWithFlatUIImage:(UIImage*)image;

/**
 *  使用已经拼接好的Flat图像数据来进行渲染
 *  @param pixelBuffer 原始图像数据，已经拼接好的全景图片, YUV420格式
 *  @return 渲染生成的图片，渲染失败返回nil
 */
- (UIImage*) renderWithFlatPixelBuffer:(CVPixelBufferRef)pixelBuffer;

/**
 *  使用相机的双圆图片来进行渲染
 *  此时offset参数起作用
 *  @param image 原始双圆图片
 *  @return 渲染生成的图片，渲染失败返回nil
 */
- (UIImage*) renderWithPanoUIImage:(UIImage*)image;

/**
 *  使用相机的双圆图像数据来进行渲染
 *  此时offset参数起作用
 *  @param pixelBuffer 未拼接的双圆图像数据, NV12格式
 *  @return 渲染生成的图片，渲染失败返回nil
 */
- (UIImage*) renderWithPanoPixelBuffer:(CVPixelBufferRef)pixelBuffer;

/**
 *  使用相机的双圆图像数据来进行渲染
 *  此时offset参数起作用
 *  @param pixelBuffer 未拼接的双圆图像数据, NV12格式
 *  @return 渲染生成的图像数据，BGRA格式，返回的图像数据需要手动释放内存, 渲染失败返回NULL
 */
- (CVPixelBufferRef) renderAndCopyWithPanoPixelBuffer:(CVPixelBufferRef)pixelBuffer;

/**
 *  渲染成NV12格式的YUV数据
 *  @param pixelBuffer 未拼接的双圆图像数据, NV12格式，
 *  @return 渲染生成图像, NV12格式，返回的图像数据需要手动释放内存, 渲染失败返回NULL
 */
- (CVPixelBufferRef) renderNV12AndCopyWithPanoPixelBuffer:(CVPixelBufferRef)pixelBuffer;

/**
 *  渲染成YUV420p格式的YUV数据
 *  @param pixelBuffer 未拼接的双圆图像数据, NV12格式，
 *  @return 渲染生成图像, YUV420格式，返回的图像数据需要手动释放内存, 渲染失败返回NULL
 */
- (CVPixelBufferRef) renderYUV420pAndCopyWithPanoPixelBuffer:(CVPixelBufferRef)pixelBuffer;


@property (nonatomic, strong) EAGLContext *glContext;

/**
 *  镜头offset值
 */
@property (nonatomic, copy) NSString *offset;

/**
 *  方向矫正开关，默认NO
 */
@property (nonatomic) BOOL enableAdjustOrientation;

/**
 *  方向矫正值
 eableAdjustOrientation 为YES时，此值其作用
 */
@property (nonatomic) GLKQuaternion adjustOrientation;

/**
 *  logo贴图的半角大小, 默认值为0
 *  取值范围为5~100，当超出此范围时，logoAngle会置为0，即不显示logo
 */
@property (nonatomic) float logoAngle;

/**
 *  logo使用的图片，当值为nil时，使用默认图片
 */
@property (nonatomic, strong) UIImage *logoImage;

/**
 *  渲染宽度
 */
@property (nonatomic, readonly) int width;

/**
 *  渲染高度
 */
@property (nonatomic, readonly) int height;

/**
 *  是否为渲染视频，默认值NO
 *  当值设置为YES时，renderWithFlatPixelBuffer和renderAndCopyWithPanoPixelBuffer将会重复使用一个CIContext，避免内存增长问题
 */
@property (nonatomic) BOOL isRenderVideo;

/**
 *  滤镜
 */
@property (nonatomic, strong) INSFilter *filter;

/**
 *  美颜滤镜
 */
@property (nonatomic, strong) INSFilter *beautifyFilter;



@end
