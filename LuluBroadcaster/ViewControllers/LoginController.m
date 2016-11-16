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

@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *blank;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *confirm;
@property (weak, nonatomic) IBOutlet UIView *panel;
@end

@implementation LoginController
#pragma mark -
#pragma mark setup
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
}

- (void)setupViews{
    //button
    _confirm.tintColor = [UIColor whiteColor];
    _confirm.layer.borderColor = [[UIColor whiteColor] CGColor];
    _confirm.layer.borderWidth = 0.8;
    _confirm.layer.cornerRadius = 3.0;
    _confirm.alpha = 0.9;
    
    //panel
    _panel.layer.cornerRadius = 6.0;
    
    //status bar
    [self preferredStatusBarStyle];
    [self prefersStatusBarHidden];
    
    //actions
    [_confirm addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchDown];
    [_blank addTarget:self action:@selector(hideInput:) forControlEvents:UIControlEventTouchDown];
    
    //text fields
    _username.delegate = self;
    _password.delegate = self;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark actions
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

- (void)hideInput: (UIButton*)sender{
    [self.view endEditing:YES];
}


#pragma mark -
#pragma mark methods
- (BOOL)checkInputStatus{
    if(self.username.text && self.password.text && [self.username.text lengthOfBytesUsingEncoding:NSASCIIStringEncoding] > 0 && [self.password.text lengthOfBytesUsingEncoding:NSASCIIStringEncoding]){
        return YES;
    }
    else{
        return NO;
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideInput:nil];
    return YES;
}

@end
