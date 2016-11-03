//
//   INSCameraVideoResType.h
//  INSNanoLivingSDK
//
//  Created by Roger on 5/7/16.
//  Copyright © 2016年 com.insta360. All rights reserved.
//


//Camera video stream resolution type
typedef NS_ENUM(NSUInteger, INSCameraVideoResType)
{
    INSCameraVideoResType_1440_720P15   = 0,            //resolution:1440 x 720     fps:15
    INSCameraVideoResType_1440_720P30   = 3,            //resolution:1440 x 720     fps:30
    INSCameraVideoResType_2160_1080P15  = 4,            //resolution:2160 x 1080    fps:15
    INSCameraVideoResType_2160_1080P30  = 7,            //resolution:2160 x 1080    fps:30
    INSCameraVideoResType_2560_1280P15  = 8,            //resolution:2560 x 1280    fps:15
    INSCameraVideoResType_2560_1280P30  = 11,           //resolution:2560 x 1280    fps:30
    INSCameraVideoResType_3040_1520P15  = 12,           //resolution:3040 x 1520    fps:15
    INSCameraVideoResType_3040_1520P30  = 15,           //resolution:3040 x 1520    fps:30
    
    INSCameraVideoResType_MAXCNT,                       //invail, used as a boundary
    INSCameraVideoResType_null,                         //null, when an error occurs
};
