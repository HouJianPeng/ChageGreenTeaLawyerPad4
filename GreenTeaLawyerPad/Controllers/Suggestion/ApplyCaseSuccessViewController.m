//
//  ApplyCaseSuccessViewController.m
//  greenTeaLawyer
//
//  Created by Herron on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "ApplyCaseSuccessViewController.h"
#import "ApplyForCaseViewController.h"
//#import "CaseViewController.h"
#import "MJRefresh.h"
static NSInteger page =1;
@interface ApplyCaseSuccessViewController ()
@property(nonatomic,retain)NSTimer * timer;
@end

@implementation ApplyCaseSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"申请成功";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(backToRootView) userInfo:nil repeats:NO];
//    [self.timer fire];
  
    // Do any additional setup after loading the view from its nib.
}
-(void)backToRootView{
    [self.timer invalidate];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}









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
