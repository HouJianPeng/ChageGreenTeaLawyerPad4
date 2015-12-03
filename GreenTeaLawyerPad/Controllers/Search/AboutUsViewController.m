//
//  AboutUsViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tellUsButton;
@property (weak, nonatomic) IBOutlet UIView *aboutUsVIew;
@property (weak, nonatomic) IBOutlet UIView *tellUsView;
@property (weak, nonatomic) IBOutlet UIButton *aboutUsButton;
@property (weak, nonatomic) IBOutlet UITextView *detialTextView;
@property (weak, nonatomic) IBOutlet UITextView *tellusTextview;
@end
@implementation AboutUsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self.aboutUsButton addTarget:self action:@selector(aboutUstheImageView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.tellUsButton addTarget:self action:@selector(tellUsTheImageView) forControlEvents:(UIControlEventTouchUpInside)];
    [self loadBlackButton];
    self.tellUsView.backgroundColor = [UIColor whiteColor];
    self.detialTextView.userInteractionEnabled = NO;
    self.tellusTextview.userInteractionEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}
-(void)loadBlackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)aboutUstheImageView{
    [self.aboutUsButton setBackgroundImage:[UIImage imageNamed:@"bb_02"] forState:UIControlStateNormal];
    [self.tellUsButton setBackgroundImage:[UIImage imageNamed:@"bb_03"] forState:UIControlStateNormal];
    [self.view bringSubviewToFront:self.aboutUsVIew];
}
-(void)tellUsTheImageView{
    [self.aboutUsButton setBackgroundImage:[UIImage imageNamed:@"aboutUsPic"] forState:UIControlStateNormal];
    [self.tellUsButton setBackgroundImage:[UIImage imageNamed:@"tellUsPic"] forState:UIControlStateNormal];
    [self.view bringSubviewToFront:self.tellUsView];
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
