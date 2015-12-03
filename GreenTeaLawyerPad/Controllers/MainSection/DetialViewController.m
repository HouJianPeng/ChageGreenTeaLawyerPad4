//
//  DetialViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/28.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import "DetialViewController.h"
#import "NewsVM.h"

@interface DetialViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *detialWebView;
@property (weak, nonatomic) IBOutlet UILabel *detaiTitle;
@end

@implementation DetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadBlackButton];
    [self netWorkForDetail];
}

- (void)netWorkForDetail
{
    NSString *url = [NSString stringWithFormat:@"http://www.lawcheck.com.cn//cosmos.json?command=scommerce.SC_ADV_ADVERTISEMENT_GET&advertisementId=%@", self.advertisementId];
    [NetWork POST:url parmater:nil Block:^(NSData *data) {
        
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSDictionary *dic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"SC_ADV_ADVERTISEMENT_GET"] objectForKey:@"list"] firstObject] firstObject];
        
        NewsModel *model = [NewsVM newsModelWithDict:dic];
        NSLog(@"%@", model);
        self.detaiTitle.text = [NSString stringWithFormat:@"%@%@",[model.newsTitle substringToIndex:10],@""];
        [self.detialWebView loadHTMLString:model.content baseURL:nil];
        NSLog(@"");
    }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
