//
//  ChangeEmailViewController.m
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "ChangeEmailViewController.h"
#import "NSString+Verify.h"

@interface ChangeEmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation ChangeEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"修改邮箱地址";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(upLoadEmail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
     self.emailTextField.text = self.emailStr;
}


- (void)upLoadEmail:(UIButton *)sender
{
    if ([NSString tf_isValidateEmail:self.emailTextField.text]) {
        [self netWork];
    } else {
//        [AlertViewManager showAlertViewWithMessage:@"邮箱格式错误!"];
        UIAlertView  * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮箱格式错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil
                                , nil];
    }
}

- (void)doBack:(UIButton *)sender
{
   
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)netWork
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_INFO_UPDATE&userId=%@&email=%@", SERVER_HOST_PRODUCT, userId, self.emailTextField.text];
    [NetWork POST:url parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSDictionary *accountDic = [[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_INFO_UPDATE"] objectForKey:@"object"];
        
        NSNumber *success = (NSNumber *)[accountDic objectForKey:@"success"];
        NSLog(@"success = %@", success);
        
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSLog(@"修改成功");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮箱修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [self.delegate sendToBasicInfoWithMessage:self.emailTextField.text];
        } else {
            NSLog(@"修改失败");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮箱修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }];
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
