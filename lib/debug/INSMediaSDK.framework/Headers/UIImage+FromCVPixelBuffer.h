//
// Created by jerett on 16/6/17.
// Copyright (c) 2016 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (FromCVPixelBuffer)

/**
 *  从CVPixelBufferRef转换到UIImage
 *
 *  @param ref imgBuffer,成功后会释放ref
 *
 *  @return UIImage
 */
+(UIImage *)imageFromCVPixelBufferRef:(CVPixelBufferRef)ref;

@end