//
//  StreamManager.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "StreamManager.h"
#import "SettingSession.h"
#import <INSNanoSDK/INSNanoSDK.h>
#import <NSLogger/NSLogger.h>

@interface StreamManager(){
    CVPixelBufferRef m_buffer;
}
@property (nonatomic, strong) dispatch_semaphore_t bufferCopySemaphore;
@end

@implementation StreamManager
#pragma mark singleton
+ (StreamManager*)sharedManager {
    static StreamManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

- (instancetype)init{
    //initilaize buffer
    m_buffer = NULL;
    
    self.bufferCopySemaphore = dispatch_semaphore_create(1);
    
    _isStreaming = NO;
    self.session = [[VCRtmpSession alloc] initWithVideoSize:VIDEO_SIZE_CIF fps:20 bitrate:BITRATE_CIF];
    return [super init];
}


- (void) dealloc{
    free(m_buffer);
}

#pragma mark -
#pragma mark methods
- (void)startRTMP{
    if (!_session)
        return;
    SettingSession* setting = [[SettingSession alloc] init];
    [self.session startRtmpSession:@"rtmp://10.10.17.182:1935/rtmplive/kjkjkj"];
    //[self.session startRtmpSession:[NSString stringWithFormat:@"%@/%@", setting.url, setting.streamKey]];
    _isStreaming = YES;
}

- (void)stopRTMP{
    if (!_session)
        return;
    _isStreaming = NO;
    [self.session endRtmpSession];
    
}

- (void)refreshBuffer: (CVPixelBufferRef)new_buffer{
    dispatch_semaphore_wait(self.bufferCopySemaphore, DISPATCH_TIME_NOW);
    
    // Get pixel buffer info
    CVPixelBufferLockBaseAddress(new_buffer, kCVPixelBufferLock_ReadOnly);
    size_t sizeToCopy = CVPixelBufferGetDataSize(new_buffer);
    int bufferWidth = (int)CVPixelBufferGetWidth(new_buffer);
    int bufferHeight = (int)CVPixelBufferGetHeight(new_buffer);
    uint8_t *baseAddress = CVPixelBufferGetBaseAddress(new_buffer);
    
    //clean the old buffer
    if(m_buffer){
        CFRelease(m_buffer);
        m_buffer = NULL;
    }
    
    // Copy the pixel buffer
    CVPixelBufferRef pixelBufferCopy = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, bufferWidth, bufferHeight, kCVPixelFormatType_32BGRA, NULL, &pixelBufferCopy);
    CVPixelBufferLockBaseAddress(pixelBufferCopy, kCVPixelBufferLock_ReadOnly);
    uint8_t *copyBaseAddress = CVPixelBufferGetBaseAddress(pixelBufferCopy);
    memcpy(copyBaseAddress, baseAddress, sizeToCopy);
    m_buffer = pixelBufferCopy;
    CVPixelBufferUnlockBaseAddress(pixelBufferCopy, kCVPixelBufferLock_ReadOnly);
    CVPixelBufferUnlockBaseAddress(new_buffer, kCVPixelBufferLock_ReadOnly);
    CFRelease(new_buffer);
    dispatch_semaphore_signal(self.bufferCopySemaphore);
}


@end
