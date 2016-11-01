//
//  UIImage+INSMediaSDK.h
//  INSMediaApp
//
//  Created by pengwx on 16/7/28.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (INSMediaSDK)

/**
 *  将图片保存到手机
 *  @param fileName 文件名称
 */
- (void) saveImageToFile:(NSString*)fileName;

/**
 *  将CVPixelBufferRef图像转换为UIImage
 *  @param pixelBuffer 输入图像 BGRA格式
 *  @return RGBA图片
 */
+ (UIImage*) imageWithPixelBuffer:(CVPixelBufferRef)pixelBuffer;

/**
 *  将RGBA的位图数据转为UIImage
 *  @param width  图片宽
 *  @param height 图片高
 *  @param data   像素数据
 *  @param ignore 转换时是否忽略alpha数据
 *  @return RGBA图片
 */
+ (UIImage*) imageWithBitmapWidth:(int)width height:(int)height RGBAData:(NSData*)data ignoreAlpha:(BOOL)ignore;


//+ (UIImage*) imageWithTexture:(int)texture context:(EAGLContext*)context;

@end
