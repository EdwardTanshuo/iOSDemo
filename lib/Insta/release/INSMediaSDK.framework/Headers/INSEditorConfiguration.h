//
//  INSEditorConfiguration.h
//  INSMediaApp
//
//  Created by jerett on 16/7/29.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INSOffscreenRender;
@class INSRenderConfiguration;
@class INSTrimConfiguration;
@class INSTrimAndRenderConfiguration;

typedef enum : NSUInteger {
    /**
     *  设置为FragmentMP4，这种类型可以用来上传
     */
    INSEditorOutputTypeFragmentMP4,
    /**
     *  导出正常的视频，用来保存到系统相册
     */
    INSEditorOutputTypeNormolMP4,
} INSEditorOutputType;


@interface INSEditorConfiguration : NSObject

+(INSRenderConfiguration*)renderConfigurationWithInputURL:(NSURL*)intputURL render:(INSOffscreenRender*)render outputURL:(NSURL*)outputURL outputWidth:(NSInteger)outputWidth outputHeight:(NSInteger)outputHeight bitrate:(NSInteger)bitrate fps:(NSInteger)fps outputType:(INSEditorOutputType)type;

+(INSTrimConfiguration*)trimConfigurationInputURL:(NSURL*)intputURL leftTimeInMs:(double)leftTimeInMs rightTimeInMs:(double)rightTimeInMs outputURL:(NSURL*)outputURL;

+(INSTrimAndRenderConfiguration*)trimAndRenderConfigurationWithInputURL:(NSURL*)intputURL leftTimeInMs:(double)leftTimeInMs rightTimeInMs:(double)rightTimeInMs render:(INSOffscreenRender*)render outputURL:(NSURL*)outputURL outputWidth:(NSInteger)outputWidth outputHeight:(NSInteger)outputHeight bitrate:(NSInteger)bitrate fps:(NSInteger)fps outputType:(INSEditorOutputType)type;

@end


/**
 *  用来转码和渲染的配置，可以导出小行星和展开全景
 */
@interface INSRenderConfiguration : INSEditorConfiguration

@property (nonatomic, strong) NSURL *inputURL;
@property (nonatomic, strong) NSURL *outputURL;
@property (nonatomic, assign) NSInteger outputWidth;
@property (nonatomic, assign) NSInteger outputHeight;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, assign) NSInteger outputFps;
@property (nonatomic, assign) INSEditorOutputType outputType;

@property (nonatomic, strong) INSOffscreenRender *render;
/**
 *  配置是否使用软编码, 默认为NO
 */
@property (nonatomic, assign) BOOL useX264Encoder;

//@property (nonatomic, assign) BOOL halfFrameRate;


/**
 配置x264编码的preset， 可以为"veryfast", "fast", 默认使用veryfast
 */
@property (nonatomic, strong) NSString *preset;

-(instancetype)initWithInputURL:(NSURL*)intputURL render:(INSOffscreenRender*)render outputURL:(NSURL*)outputURL outputWidth:(NSInteger)outputWidth outputHeight:(NSInteger)outputHeight bitrate:(NSInteger)bitrate fps:(NSInteger)fps outputType:(INSEditorOutputType)type;

@end


/**
 *  只用来做视频的trim操作，不会进行边解码操作，速度很快
 */
@interface INSTrimConfiguration: INSEditorConfiguration

@property (nonatomic, strong) NSURL *inputURL;
@property (nonatomic, strong) NSURL *outputURL;
@property (nonatomic, assign) NSUInteger leftTimeInMs;
@property (nonatomic, assign) NSUInteger rightTimeInMs;

-(instancetype)initWithInputURL:(NSURL*)intputURL leftTimeInMs:(double)leftTimeInMs rightTimeInMs:(double)rightTimeInMs outputURL:(NSURL*)outputURL;

@end


/**
 *  只用来做视频的trim操作和render的操作，需要边解码
 */
@interface INSTrimAndRenderConfiguration: INSRenderConfiguration

@property (nonatomic, assign) NSUInteger leftTimeInMs;
@property (nonatomic, assign) NSUInteger rightTimeInMs;

-(instancetype)initWithInputURL:(NSURL*)intputURL leftTimeInMs:(double)leftTimeInMs rightTimeInMs:(double)rightTimeInMs render:(INSOffscreenRender*)render outputURL:(NSURL*)outputURL outputWidth:(NSInteger)outputWidth outputHeight:(NSInteger)outputHeight bitrate:(NSInteger)bitrate fps:(NSInteger)fps outputType:(INSEditorOutputType)type;

@end

















