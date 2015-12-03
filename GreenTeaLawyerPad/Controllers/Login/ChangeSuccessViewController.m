//
//  ChangeSuccessViewController.m
//  greenTea
//
//  Created by Herron on 15/7/3.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "ChangeSuccessViewController.h"

#import "LoginViewController.h"

@interface ChangeSuccessViewController ()

@end

@implementation ChangeSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    // Do any additional setup after loading the view from its nib.
    
    [self.showLabel setText:self.showStr];
}

- (void)doBack:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)loginNow:(id)sender
{
    LoginViewController * login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
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
