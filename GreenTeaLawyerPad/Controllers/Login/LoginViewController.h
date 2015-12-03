//
//  LoginViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/13.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField; // 手机号
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;    // 密码
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;             // 登录按钮
@property (weak, nonatomic) IBOutlet UIButton *registButton;            // 注册按钮
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;    // 忘记密码按钮

@end
