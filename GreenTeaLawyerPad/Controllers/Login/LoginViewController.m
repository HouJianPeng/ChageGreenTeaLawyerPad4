//
//  LoginViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/13.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "LoginViewController.h"
//#import "RegistViewController.h"
//#import "ForgetPasswordViewController.h"
//#import "HomeViewController.h"
#import "AFNetworking.h"
#import "NSString+Validation.h"
#import "NetworkMacro.h"
#import "AccountManager.h"
#import "Account.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@end

@implementation LoginViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"用户登录";
    [self loadBlackButton];
    [self.phoneNumberTextField setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login1"]]];
    [self.phoneNumberTextField.leftView setFrame:CGRectMake(22, 0, 20, 30)];
    self.phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.passwordTextField setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login2"]]];
    [self.passwordTextField.leftView setFrame:CGRectMake(22, 0, 20, 30)];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)loadBlackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}




#pragma mark - 点击登录
- (IBAction)LoginClick:(id)sender
{
    
    if ([_phoneNumberTextField.text validateMobile:_phoneNumberTextField.text])
    {
        if([_passwordTextField.text isEqualToString:@""])
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"请输入密码" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            // 1.管理器
            AFHTTPRequestOperationManager *manager =  [AFHTTPRequestOperationManager manager];
            // 申明返回的结果是json类型
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            // 申明请求的数据是json类型
            manager.requestSerializer=[AFJSONRequestSerializer serializer];
            // 如果报接受类型不一致请替换一致text/html或别的
            [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"xml/json", nil]];
            // 2.设置登录参数
            NSDictionary *dict = @{ @"userName":_phoneNumberTextField.text, @"credentials": [NSString stringWithFormat:@"userName=%@|password=%@", _phoneNumberTextField.text, _passwordTextField.text]};
            // 3.发送请求
            [manager GET:LoginURL parameters:dict
                 success:^(AFHTTPRequestOperation *operation, NSString * responseObject)
             {
                 NSDictionary *dic = (NSDictionary *)responseObject;
                 NSLog(@"dic == %@", dic);
                 
                 NSDictionary *accountDic = [[[[dic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_SYS_LOGIN"] objectForKey:@"object"];
                 
                 
                 NSString *result = [accountDic objectForKey:@"result"];
                 
                 NSLog(@"result == %@", result);
                 NSNumber *r = (NSNumber *)result;
                 
                 if ([r isEqualToNumber:[NSNumber numberWithInt:-5]])
                 {
                     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的账号或密码输入有误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                     [alert show];
                 } else if ([r isEqualToNumber:[NSNumber numberWithInt:-1]]) {
                     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户不存在" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                     [alert show];
                     
                 } else if (![[accountDic objectForKey:@"userType4session"] isEqualToString:@"lawyer"]) {
                     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户不存在" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                     [alert show];
                     
                 } else {
                     NSLog(@"登陆成功");
                     // 保存账号信息
                     Account *account = [Account initAccount:accountDic];
                     account.isLogin = @"yes";
                     [AccountManager sharedInstance].account = account;
                     [[AccountManager sharedInstance] saveAccountInfoToDisk];
                     [self.navigationController popToRootViewControllerAnimated:YES];
                 }
             }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 NSLog(@"error == %@",error);
                 
                 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不好请重试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }];
        }
    }
}

#pragma mark - 注册
- (IBAction)RegistAction:(id)sender
{
//    RegistViewController *registViewController = [[RegistViewController alloc] init];
//    [self.navigationController pushViewController:registViewController animated:YES];
    NSLog(@"您点击了注册");
    RegisterViewController * regist = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

#pragma mark - 忘记密码
- (IBAction)forgetAction:(id)sender
{
    ForgetPasswordViewController *forgetPasswordViewController = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    NSLog(@"您忘记了密码");
}

- (void)doBack:(UIButton *)sender
{
    [AccountManager changeRootVCWithMMDrawer];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
