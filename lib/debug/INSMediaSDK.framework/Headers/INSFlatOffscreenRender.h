//
//  INSFlatOffscreenRender.h
//  INSVideoPlayApp
//
//  Created by pwx on 17/2/16.
//  Copyright © 2016年 insta360. All rights reserved.
//

#import "INSOffscreenRender.h"

@interface INSFlatOffscreenRender : INSOffscreenRender


//初始化
- (instancetype) initWithRenderWidth:(int)width height:(int)height;

//渲染图片, 失败返回nil
- (UIImage*) renderImage:(UIImage *)image;
- (UIImage*) renderImageWithURL:(NSURL *)url;

//渲染CVPixelBufferRef, 失败返回nil
- (UIImage*) renderVideo:(CVPixelBufferRef)pixelBuffer;

//渲染CVPixelBufferRef, 失败返回NULL
- (CVPixelBufferRef) createPixelBufferFramRenderVideo:(CVPixelBufferRef)pixelBuffer;


/**
 *  交换镜头位置   默认值：NO
 *  设置此参数为YES，会使渲染出来flat图像中间部分与两边的图像进行交换
 */
@property (nonatomic) BOOL swapLensPosition;


@end
