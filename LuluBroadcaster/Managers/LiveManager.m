//
//  LiveManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//



#import "LiveManager.h"
#import "SettingSession.h"

#import <INSNanoSDK/INSNanoSDK.h>

@interface LiveManager()<INSLiveDataSourceProtocol>

@property (nonatomic, strong) INSLiveDataSource* liveDataSource;

@end

@implementation LiveManager
#pragma mark singleton
+ (LiveManager*)sharedManager {
    static LiveManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.pixelBufferInput = [[YUGPUImageCVPixelBufferInput alloc] init];
    });
    return sharedMyManager;
}

- (void) dealloc{
    [[INSCameraAccessory defaultCamera] removeObserver:self forKeyPath:@"status"];
}



#pragma mark -
#pragma mark INSLiveDataSourceProtocol

- (void) sourceOnError:(NSError *)error{
    [_delegate recieveError:error];
}

- (void) sourceOnH264Header:(const uint8_t *)sps spsSize:(size_t)spsSize pps:(const uint8_t *)pps ppsSize:(size_t)ppsSize{
}

- (void) sourceOnH264Nalu:(NSData *)nalu keyFrame:(BOOL)isKey timestamp:(int64_t)timestamp{
    
}

- (void) sourceOnAACHeader:(const uint8_t *)aacHeader size:(size_t)headerSize{
    
}

- (void) sourceOnAACData:(const uint8_t *)aacData size:(size_t)size timestamp:(int64_t)timestamp{
    
}

- (void) sourceOnH264Nalu:(const uint8_t *)nalu size:(size_t)size keyFrame:(BOOL)isKey timestamp:(int64_t)timestamp{
    
}


- (void) sourceOnAACData:(NSData *)aacData timestamp:(int64_t)timestamp{
    
}

- (void) sourceOnRawPixelBuffer:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
    
    [_delegate recieveOnRawFragment:pixelBuffer timestamp:timestamp];
}

- (void) sourceOnStitchPixelBuffer:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
    [self parsePixelBuffer: pixelBuffer];
    [_delegate recieveStichedFragment:pixelBuffer timestamp:timestamp];
}

#pragma mark methods
- (void)startLiveWithWidth:(NSInteger)stitchWidth WithHeight:(NSInteger)stitchHeight WithBitrate:(NSInteger)bitrate{
    self.liveDataSource = [[INSLiveDataSource alloc] initWitCameraResolution:INSCameraVideoResType_3040_1520P30 stitchWidth:stitchWidth stitchHeight:stitchHeight bitrate:bitrate];
    self.liveDataSource.dataSourceDelegate = self;
    [self.liveDataSource start];
}

- (void)startLive{
    SettingSession* session = [[SettingSession alloc] init];
    [self startLiveWithWidth:session.width WithHeight:session.height WithBitrate:session.bitrate];
}

- (void)stopLive{
    [self.liveDataSource stop];
    self.liveDataSource = nil;
}

- (void)parsePixelBuffer:(CVPixelBufferRef)pixelBuffer{
     [self.pixelBufferInput processCVPixelBuffer:pixelBuffer];
}
@end

