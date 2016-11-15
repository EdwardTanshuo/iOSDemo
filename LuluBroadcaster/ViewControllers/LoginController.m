//
//  LoginController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/14/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LoginController.h"
#import "LoginRequest.h"
#import "NavigationRouter.h"

#import "AppDelegate.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *confirm;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
}

- (void)setupViews{
    [_confirm addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark -
#pragma mark methods
- (void)loginAction: (UIButton*)sender{
    if(![self checkInputStatus]){
        [NavigationRouter showAlertInViewController:self WithTitle:@"用户信息不全" WithMessage:@"请检查用户名或者密码"];
        return;
    }
    sender.userInteractionEnabled = NO;
    [[LoginRequest sharedRequest] login:^(Broadcaster * _Nullable broadcaster, NSError * _Nullable error) {
        sender.userInteractionEnabled = YES;
        if(broadcaster){
            [NavigationRouter showTabControllerOnWindow:((AppDelegate*)[UIApplication sharedApplication]).window];
        }
        else{
            [NavigationRouter showAlertInViewController:self WithTitle:@"登陆错误" WithMessage:@"请检查用户名或者密码"];
        }
    }];
}

- (BOOL)checkInputStatus{
    if(self.username.text && self.password.text && [self.username.text lengthOfBytesUsingEncoding:NSASCIIStringEncoding] > 0 && [self.password.text lengthOfBytesUsingEncoding:NSASCIIStringEncoding]){
        return YES;
    }
    else{
        return NO;
    }
}

@end
