//
//  GPUImageBeautifyFilter.h
//
// Created by Shuo Tan on 10/29/16.
//

#import <GPUImage/GPUImageFramework.h>

@class GPUImageMyCombinationFilter;

@interface GPUImageMyBeautifyFilter : GPUImageFilterGroup {
    GPUImageBilateralFilter *bilateralFilter;
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;
    GPUImageMyCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}

@end
