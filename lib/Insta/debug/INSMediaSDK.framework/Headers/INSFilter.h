//
//  INSFilter.h
//  INSMediaApp
//
//  Created by pengwx on 3/18/16.
//  Copyright © 2016 Insta360. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

#define STRINGIZE(x) #x
#define STRINGIZE2(x) STRINGIZE(x)
#define SHADER_STRING(text) @ STRINGIZE2(text)


#define FilterTextureUnit   GL_TEXTURE2                 //滤镜使用的textureunit 起点
#define TextureSample(X)    (X-GL_TEXTURE0)             //取样器计算
#define FilterTextureMaxUnit  GL_TEXTURE7               //最大纹理单元


extern NSString *const kGPUImageVertexShaderString;
extern NSString *const kGPUImagePassthroughFragmentShaderString;


/*struct GPUVector4 {
    GLfloat one;
    GLfloat two;
    GLfloat three;
    GLfloat four;
};
typedef struct GPUVector4 GPUVector4;

struct GPUVector3 {
    GLfloat one;
    GLfloat two;
    GLfloat three;
};
typedef struct GPUVector3 GPUVector3;

struct GPUMatrix4x4 {
    GPUVector4 one;
    GPUVector4 two;
    GPUVector4 three;
    GPUVector4 four;
};
typedef struct GPUMatrix4x4 GPUMatrix4x4;

struct GPUMatrix3x3 {
    GPUVector3 one;
    GPUVector3 two;
    GPUVector3 three;
};
typedef struct GPUMatrix3x3 GPUMatrix3x3;*/

typedef NS_ENUM(NSUInteger, INSFilterType) {
    INSFilterTypeNull,                  //无滤镜
    //beautify
    INSFilterTypeBeautify1,
    INSFilterTypeBeautify2,
    INSFilterTypeBeautify3,
    INSFilterTypeBeautify4,
    INSFilterTypeBeautify5,
    
    //GPUImage
    INSFilterTypeMissEtikate,           //3
    
    //FW
    INSFilterTypeNashville,
    INSFilterTypeLordKelvin,
    INSFilterTypeAmaro,
    INSFilterTypeRise,                  //7
    INSFilterTypeHudson,                //8
    INSFilterType1977,                  //10
    INSFilterTypeWalden,                //12
    INSFilterTypeLomofi,                //13
    INSFilterTypeHefe,                  //20
    INSFilterTypeXproII,                //9
    INSFilterTypeInkwell,               //14
    INSFilterTypeSierra,                //15
    INSFilterTypeEarlybird,             //16
    INSFilterTypeSutro,                 //17
    INSFilterTypeGray,                  //灰度

    //
    INSFilterTypeMax,
};

@class INSRenderTarget;
@class INSMaterial;
@class INSScene;
@class INSTexture;


@interface INSFilter : NSObject{
    GLuint _program;
    GLint filterPositionAttribute;
    GLint filterTextureCoordinateAttribute;
    GLint filterInputTextureUniform;
//
//    GLint _position;
//    GLint _inputTextureCoordinate;
    CGSize _size;
    
}

//@property (nonatomic) GLint textureSample;

- (instancetype) initWithVertexShaderString:(NSString*)vertexString fragmentShaderString:(NSString*)fragmentString;

- (instancetype) initWithFragmentShaderString:(NSString*)fragmentString;


- (void) resetVertexShaderString:(NSString*)vertexString fragmentShaderString:(NSString*)fragmentString;

- (void)setupFilterForSize:(CGSize)filterFrameSize;
- (void)setUniformsForProgramAtIndex:(NSUInteger)programIndex;

- (INSScene*) createRenderSceneWithInputTexture:(NSArray*)texture output:(INSRenderTarget*)renderTarget;

@property (nonatomic, strong, readonly) INSMaterial *material;

@property (nonatomic, readonly) INSFilterType type;


+ (INSFilter*) filterWithType:(INSFilterType)type;

/**
 *  获取滤镜的字符表示方式, 当type为INSFilterTypeNull或者无效时返回nil
 *  @param type 滤镜类型
 *  @return 滤镜字符表示
 */
+ (NSString*) stringWithType:(INSFilterType)type;

/**
 *  获取滤镜的枚举表示方式,   当string为nil或无效时返回INSFilterTypeNull
 *  @param string 滤镜类型字符表示
 *  @return 滤镜枚举表示
 */
+ (INSFilterType) typeWithString:(NSString*)string;

@end
