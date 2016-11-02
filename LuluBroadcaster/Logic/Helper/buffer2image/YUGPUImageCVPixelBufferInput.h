//
//  YUGPUImageCVPixelBufferInput.h
//  Pods
//
//  Created by Shuo Tan on 10/29/16.
//
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface YUGPUImageCVPixelBufferInput : GPUImageOutput

- (BOOL)processCVPixelBuffer:(CVPixelBufferRef)pixelBuffer;

- (BOOL)processCVPixelBuffer:(CVPixelBufferRef)pixelBuffer frameTime:(CMTime)frameTime;

- (BOOL)processCVPixelBuffer:(CVPixelBufferRef)pixelBuffer frameTime:(CMTime)frameTime completion:(void (^)(void))completion;

@end
