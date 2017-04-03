//
//  SettingSession.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "SettingSession.h"

#define BITRATE_KEY @"bitrateKey"
#define HEIGHT_KEY @"heightKey"
#define WIDTH_KEY @"widthKey"
#define URL_KEY @"urlKey"
#define STREAM_TOKEN_KEY @"streamKey"
#define BRIGHTNESS_KEY @"brightnessKey"
#define FPS_KEY @"fpsKey"
#define FACE_DETECTOR_KEY @"fdKey"
#define QUALITY_KEY @"qualityKey"

#define DEFAULT_BITRATE 2*1024*1024
#define DEFAULT_HEIGHT 720
#define DEFAULT_WIDTH 1440
#define DEFAULT_URL @"rtmp://122.112.246.201:1935/rtmplive"
#define DEFAULT_STREAM_KEY @"kjkjkj"
#define DEFAULT_BRIGHTNESS 0.2
#define DEFAULT_FPS 30
#define DEFAULT_FACE_DETECTOR 1
#define DEFAULT_QUALITY SettingSessionCameraQualityReal


@interface SettingSession()

@end

@implementation SettingSession
@synthesize bitrate = _bitrate;
@synthesize width = _width;
@synthesize height = _height;
@synthesize url = _url;
@synthesize streamKey = _streamKey;
@synthesize brightness = _brightness;
@synthesize fps = _fps;
@synthesize faceDetectOn = _faceDetectOn;
@synthesize quality = _quality;

#pragma mark quality
- (SettingSessionCameraQuality) quality{
    _quality = [[NSUserDefaults standardUserDefaults] integerForKey:QUALITY_KEY];
    return _quality;
}
- (void) setQuality:(SettingSessionCameraQuality)new_value{
    [[NSUserDefaults standardUserDefaults] setInteger:new_value forKey:QUALITY_KEY];
}

#pragma mark bitrate
- (NSUInteger) bitrate{
    _bitrate = [[NSUserDefaults standardUserDefaults] integerForKey:BITRATE_KEY];
    if(!_bitrate){
        [[NSUserDefaults standardUserDefaults] setInteger:DEFAULT_BITRATE forKey:BITRATE_KEY];
        return DEFAULT_BITRATE;
    }
    return _bitrate;
}
- (void) setBitrate:(NSUInteger)new_value{
    [[NSUserDefaults standardUserDefaults] setInteger:new_value forKey:BITRATE_KEY];
}

#pragma mark face detector on
- (BOOL) faceDetectOn{
    _faceDetectOn = [[NSUserDefaults standardUserDefaults] boolForKey:FACE_DETECTOR_KEY];
   
    return _faceDetectOn;
}
- (void) setFaceDetectOn:(BOOL)new_value{
    [[NSUserDefaults standardUserDefaults] setInteger:new_value forKey:FACE_DETECTOR_KEY];
}


#pragma mark fps
- (NSUInteger) fps{
    _fps = [[NSUserDefaults standardUserDefaults] integerForKey:FPS_KEY];
    if(!_fps){
        [[NSUserDefaults standardUserDefaults] setInteger:DEFAULT_FPS forKey:FPS_KEY];
        return DEFAULT_FPS;
    }
    return _fps;
}
- (void) setFps:(NSUInteger)new_value{
    [[NSUserDefaults standardUserDefaults] setInteger:new_value forKey:FPS_KEY];
}

#pragma mark brightness
- (double) brightness{
    _brightness = [[NSUserDefaults standardUserDefaults] doubleForKey:BRIGHTNESS_KEY];
    return _brightness;
}
- (void) setBrightness:(double)new_value{
    [[NSUserDefaults standardUserDefaults] setDouble:new_value forKey:BRIGHTNESS_KEY];
}


#pragma mark width
- (NSUInteger) width{
    _width = [[NSUserDefaults standardUserDefaults] integerForKey:WIDTH_KEY];
    if(!_width){
        [[NSUserDefaults standardUserDefaults] setInteger:DEFAULT_WIDTH forKey:WIDTH_KEY];
        return DEFAULT_WIDTH;
    }
    return _width;
}
- (void) setWidth:(NSUInteger)width{
    [[NSUserDefaults standardUserDefaults] setInteger:width forKey:WIDTH_KEY];
}

#pragma mark height
- (NSUInteger) height{
    _height = [[NSUserDefaults standardUserDefaults] integerForKey:HEIGHT_KEY];
    if(!_height){
        [[NSUserDefaults standardUserDefaults] setInteger:DEFAULT_HEIGHT forKey:HEIGHT_KEY];
        return DEFAULT_HEIGHT;
    }
    return _height;
}
- (void) setHeight:(NSUInteger)height{
    [[NSUserDefaults standardUserDefaults] setInteger:height forKey:HEIGHT_KEY];
}

#pragma mark url
- (NSString*) url{
    _url = [[NSUserDefaults standardUserDefaults] objectForKey:URL_KEY];
    if(!_url){
        [[NSUserDefaults standardUserDefaults] setObject:DEFAULT_URL forKey:URL_KEY];
        return DEFAULT_URL;
    }
    return _url;
}
- (void) setUrl:(NSString*)url{
      [[NSUserDefaults standardUserDefaults] setObject:url forKey:URL_KEY];
}

#pragma mark streamKey
- (NSString*) streamKey{
    _streamKey = [[NSUserDefaults standardUserDefaults] objectForKey:STREAM_TOKEN_KEY];
    if(!_streamKey){
        [[NSUserDefaults standardUserDefaults] setObject:DEFAULT_STREAM_KEY forKey:STREAM_TOKEN_KEY];
        return DEFAULT_STREAM_KEY;
    }
    return _streamKey;
}
- (void) setStreamKey:(NSString*)streamKey{
    [[NSUserDefaults standardUserDefaults] setObject:streamKey forKey:STREAM_TOKEN_KEY];
}

@end
