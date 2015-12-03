//
//  ConslutionViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "ConslutionViewController.h"

@interface ConslutionViewController ()<UIWebViewDelegate>
{
    UIWebView *protWebView;
}
@property (retain, nonatomic) IBOutlet UIWebView *protWebView;
@end

@implementation ConslutionViewController
@synthesize protWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBlackButton];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.title= @"咨询";
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://chat.looyuoms.com/chat/chat/p.do?c=20000665&f=10050116&g=10054615"];//乐语地址
    
    [protWebView loadRequest:[NSURLRequest requestWithURL:url]];
    [self reloadInputViews];
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

//几个代理方法

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
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
