//
//  INSVideoEditor.h
//  INSMediaApp
//
//  Created by jerett on 16/7/29.
//  Copyright © 2016年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INSEditorConfiguration;
@class INSVideoEditor;


typedef enum : NSUInteger {
    INSVideoEditorStateEnd,
} INSVideoEditorState;

@protocol INSVideoEditorProtocol <NSObject>

-(void)editor:(INSVideoEditor*)editor onProgress:(double)progress;
-(void)editor:(INSVideoEditor*)editor onStateChanged:(INSVideoEditorState)state;
-(void)editor:(INSVideoEditor*)editor onError:(NSError*)error;

@end

@interface INSVideoEditor : NSObject

-(instancetype)initWithConfiguration:(INSEditorConfiguration*)configuration;
-(BOOL)run;
-(void)cancel;

@property (weak, nonatomic) id<INSVideoEditorProtocol> delegate;

/**
 *  预测的视频大小，run结束后，可以访问
 */
@property (assign, nonatomic, readonly) NSUInteger estimateSize;


@end
