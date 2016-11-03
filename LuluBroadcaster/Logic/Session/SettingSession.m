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

#define DEFAULT_BITRATE 2*1024*1024
#define DEFAULT_HEIGHT 720
#define DEFAULT_WIDTH 1440
#define DEFAULT_URL @"rtmp://182.254.151.173:1935/live/"
#define DEFAULT_STREAM_KEY @"kjkjkj"

@interface SettingSession()

@end

@implementation SettingSession
@synthesize bitrate = _bitrate;
@synthesize width = _width;
@synthesize height = _height;
@synthesize url = _url;
@synthesize streamKey = _streamKey;

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
