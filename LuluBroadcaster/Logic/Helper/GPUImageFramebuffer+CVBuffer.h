//
//  GPUImageFramebuffer+CVBuffer.h
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/2/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "GPUImage.h"

@interface GPUImageFramebuffer (CVBuffer)
- (CVPixelBufferRef) pixelBuffer;
@end
