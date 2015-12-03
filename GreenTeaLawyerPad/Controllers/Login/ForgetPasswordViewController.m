//
//  ForgetPasswordViewController.m
//  greenTea
//
//  Created by Herron on 15/7/2.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ChangeSuccessViewController.h"
#import "NSString+Validation.h"
#import "NetWork.h"
#import "NetworkMacro.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"找回密码";
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}




#pragma mark - 点击确认重置密码
- (IBAction)confirmAction:(id)sender
{
    
    if([self checkInput]){
        
        NSDictionary *dic = @{@"mcode":self.verificationTextfield.text, @"userName":self.phoneNumberTextField.text, @"userpassword":self.setupPasswordTextField.text};
        [NetWork GET:ResetPasswordURL parmater:dic Block:^(NSData *data) {
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"dataDic == %@", dataDic);
            
            NSDictionary *accountDic = [[[[dataDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_RESET_PASSWORD"] objectForKey:@"object"];
            
            NSString *result = [accountDic objectForKey:@"success"];
            NSLog(@"result = %@", result);
            NSNumber *r = (NSNumber *)result;
            
            if ([r isEqualToNumber:[NSNumber numberWithInt:1]]) {
                
                // !!检查返回信息
                Account *account = [Account initAccount:accountDic];
                [AccountManager sharedInstance].account = account;
                [[AccountManager sharedInstance] saveAccountInfoToDisk];
                
                ChangeSuccessViewController *changeSuccessViewController = [[ChangeSuccessViewController alloc] init];
                changeSuccessViewController.showStr = @"修改密码成功";
                [self.navigationController pushViewController:changeSuccessViewController animated:YES];
            } else if ([r isEqualToNumber:[NSNumber numberWithInt:2]]){
                [self showAlertWithTitle:@"验证码有误" cancelButtonTitle:@"确定"];
            } else {
                [self showAlertWithTitle:@"用户不存在" cancelButtonTitle:@"确定"];
            }
            
        }];
    }
    
}


- (void)showAlertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - 检查输入
- (BOOL)checkInput
{
    if ([self.phoneNumberTextField.text validateMobile:self.phoneNumberTextField.text]) {
        if (![self.setupPasswordTextField.text length]) {
            [self showAlertWithTitle:@"密码不能为空" cancelButtonTitle:@"确定"];
            return NO;
        } else if (![self.setupPasswordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
            [self showAlertWithTitle:@"两次密码输入不一致" cancelButtonTitle:@"确定"];
            return NO;
        } else {
            if (![self.verificationTextfield.text length]) {
                [self showAlertWithTitle:@"请输入验证码" cancelButtonTitle:@"确定"];
                return NO;
            } else{
                return YES;
            }
        }
        
    }
    return NO;
}


#pragma mark - 点击获取验证码
- (IBAction)gainVerificationAction:(id)sender {
    
    // 判断输入电话
    if ([_phoneNumberTextField.text validateMobile:_phoneNumberTextField.text]) {
        
        NSDictionary *dic = @{@"phoneNumbers":_phoneNumberTextField.text, @"content":@"【绿茶网】尊敬的用户，您在进行绿茶网的重置密码操作，验证码：<vcode>，请妥善保管。", @"validateEvent":@"forgetLoginPwd"};
        
        [NetWork GET:ResetPasswordMessageURL parmater:dic Block:^(NSData *data) {
            
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSString *result = [[[[[myDic objectForKey:@"result"] objectForKey:@"config"] objectForKey:@"smsSender"] objectForKey:@"object"] objectForKey:@"succeed"];
            
            NSLog(@"succeed = %@", result);
        }];
        
        [self timeCountDown];
    }

    
}


#pragma mark - 倒计时
- (void)timeCountDown
{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _gainVerificationButton.userInteractionEnabled = YES;
                _gainVerificationButton.backgroundColor = [UIColor lightGrayColor];
                [_gainVerificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d秒后重发", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                _gainVerificationButton.userInteractionEnabled = NO;
                _gainVerificationButton.backgroundColor = [UIColor lightGrayColor];
                //设置界面的按钮显示 根据自己需求设置
                [_gainVerificationButton setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


#pragma mark - 返回上级页面
- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
