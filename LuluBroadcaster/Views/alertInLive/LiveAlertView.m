//
//  LiveAlertView.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/16/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LiveAlertView.h"

#define DURATION 3.0f
#define FADE_DURATION 0.5f

@interface LiveAlertView()
@property (strong, nonatomic, nullable) NSError* error;
@property (strong, nonatomic, nullable) NSTimer* timer;
@end

@implementation LiveAlertView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textColor = [UIColor lightTextColor];
        self.font = [UIFont systemFontOfSize:23.0f];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 8.0f;
        _timer = [NSTimer scheduledTimerWithTimeInterval:DURATION target:self selector:@selector(timeUp) userInfo:nil repeats:NO];
    }
    return self;
}

- (void)setupLabel: (NSError*) error{
    self.error = error;
    self.text = [error.userInfo objectForKey:@"msg"];
}

- (void)timeUp{
    [UIView animateWithDuration:FADE_DURATION animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.timer invalidate];
    }];
}


+ (void)popOutInController: (UIViewController* _Nonnull)controller error: (NSError*)err{
    LiveAlertView* view = [[LiveAlertView alloc] init];
    [view setupLabel:err];
    view.frame = CGRectMake(0, 0, controller.view.bounds.size.width / 2.0f, controller.view.bounds.size.width / 2.0f * 9.0f / 16.0f);
    view.center = controller.view.center;
    [controller.view addSubview:view];
}
@end
