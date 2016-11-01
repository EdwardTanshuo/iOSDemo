//
//  INSMediaSDK.h
//  INSMediaSDK
//
//  Created by pwx on 9/3/16.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for INSMediaSDK.
FOUNDATION_EXPORT double INSMediaSDKVersionNumber;

//! Project version string for INSMediaSDK.
FOUNDATION_EXPORT const unsigned char INSMediaSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <INSMediaSDK/PublicHeader.h>


#import <INSMediaSDK/version.h>
#import <INSMediaSDK/INSMotionData.h>
#import <INSMediaSDK/UIImage+INSMediaSDK.h>
#import <INSMediaSDK/UIImage+FromCVPixelBuffer.h>
#import <INSMediaSDK/INSMediaGyro.h>
#import <INSMediaSDK/INSMediaGps.h>
#import <INSMediaSDK/INSMediaOrientation.h>
#import <INSMediaSDK/INSExtraInfo.h>
#import <INSMediaSDK/INSExtraJsonInfo.h>
#import <INSMediaSDK/INSImageInfoParser.h>
#import <INSMediaSDK/INSVideoInfoParser.h>


#import <INSMediaSDK/INSEditorConfiguration.h>
#import <INSMediaSDK/INSVideoEditor.h>

#import <INSMediaSDK/INSPlayerProtocol.h>
#import <INSMediaSDK/INSPlayer.h>

#import <INSMediaSDK/INSLens.h>
#import <INSMediaSDK/INSLensOffset.h>

#import <INSMediaSDK/INS3DObject.h>
#import <INSMediaSDK/INSCamera.h>
#import <INSMediaSDK/INSRenderManager.h>
#import <INSMediaSDK/INSVideoDisplayLink.h>

#import <INSMediaSDK/INSRenderType.h>
#import <INSMediaSDK/INSRender.h>
#import <INSMediaSDK/INSDuplicateRender.h>
#import <INSMediaSDK/INSOffscreenRender.h>
#import <INSMediaSDK/INSFlatOffscreenRender.h>
#import <INSMediaSDK/INSSphericalOffscreenRender.h>
#import <INSMediaSDK/INSFlatPanoRender.h>
#import <INSMediaSDK/INSPreviewRender.h>
#import <INSMediaSDK/INSSphericalPanoRender.h>
#import <INSMediaSDK/INSSphericalParallaxRender.h>
#import <INSMediaSDK/INSSphericalRender.h>
#import <INSMediaSDK/INSParallaxPanoRender.h>
#import <INSMediaSDK/INSNormalRender.h>

#import <INSMediaSDK/INSFilter.h>
#import <INSMediaSDK/INSProjectionStrategy.h>
#import <INSMediaSDK/INSRenderView.h>
