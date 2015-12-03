//
//  ForgetPasswordViewController.h
//  greenTea
//
//  Created by Herron on 15/7/2.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;     // 手机号
@property (weak, nonatomic) IBOutlet UITextField *verificationTextfield;    // 验证码
@property (weak, nonatomic) IBOutlet UITextField *setupPasswordTextField;   // 设置手机号
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField; // 确认手机号
@property (weak, nonatomic) IBOutlet UIButton *gainVerificationButton;      // 获取验证码按钮

@end
