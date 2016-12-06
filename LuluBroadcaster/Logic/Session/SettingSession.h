//
//  SettingSession.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SettingSessionCameraQuality) {
    SettingSessionCameraQualityLow = 0,
    SettingSessionCameraQualityMedium = 1,
    SettingSessionCameraQualityHigh = 2,
    SettingSessionCameraQualityReal = 3
};

@interface SettingSession : NSObject

#pragma mark -
#pragma mark - video quality
@property (nonatomic, assign) NSUInteger bitrate;
@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, assign) NSUInteger height;
@property (nonatomic, assign) NSUInteger fps;

#pragma mark -
#pragma mark - camera sample quanlity
@property (nonatomic, assign) SettingSessionCameraQuality quality;

#pragma mark -
#pragma mark - video filter
@property (nonatomic, assign) double brightness;
@property (nonatomic, assign) BOOL smoothFilterOn;

#pragma mark -
#pragma mark - rtmp info
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* streamKey;

#pragma mark -
#pragma mark - face detector
@property (nonatomic, assign) BOOL faceDetectOn;
@end
