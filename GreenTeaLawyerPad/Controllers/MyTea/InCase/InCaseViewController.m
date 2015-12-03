//
//  InCaseViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "InCaseViewController.h"
#import "CaseManager.h"

@interface InCaseViewController ()

@property (nonatomic, retain) NSDictionary *caseDic;

@end

@implementation InCaseViewController

- (void)viewDidLoad {
    self.caseDic = [NSDictionary dictionary];
    [super viewDidLoad];
    [self loadTheViewController];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.title = @"接单详情";
    self.caseDetailTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.caseDetailTextView.layer.borderWidth = 1;
    self.caseDetailTextView.layer.cornerRadius = 5;
    self.caseDetailTextView.layer.masksToBounds = YES;
    self.myReplyTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myReplyTextView.layer.borderWidth = 1;
    self.myReplyTextView.layer.cornerRadius = 5;
    self.myReplyTextView.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
    [self netWork2];
}
-(void)loadTheViewController{
    self.caseNumLabel.text = self.caseNumber;
    self.caseTypeLabel.text = self.caseType;
    self.caseStateLabel.text = self.caseState;
    self.caseDetailTextView.text = self.caseDetail;
}

- (void)netWork2
{
    self.caseDic = [@{} mutableCopy];
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
    //    NSDictionary *dic = @{@"cosmosPassportId":userId, @"lawcaseId":self.caseId};
    
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_CASE_LAWYERCASE_GET_BLOCK&cosmosPassportId=%@&lawcaseId=%@",SERVER_HOST_PRODUCT, userId,self.caseId];
    
//    NSLog(@"url = %@", url);
    
    [NetWork GET:url parmater:nil Block:^(NSData *data) {
        
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@", myDic);
        
        self.caseDic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWYERCASE_GET_BLOCK"] objectForKey:@"list"] firstObject] firstObject];
//        CaseModel *model = [CaseManager caseModelWithDict:self.caseDic];
//        NSString * str = [NSString stringWithFormat:@"期望薪金:   %@元",self.caseDic[@"price"]];
//        NSString *time = [NSString stringWithFormat:@"执行案例时间:   %@月",self.caseDic[@"cycleTime"]];
//        self.myReplyTextView.text = self.caseDic[@"reply"];
//        self.moneyLabel.text = str;
//        self.timeLabel.text = time;
        
        CaseModel *model = [CaseManager caseModelWithDict:self.caseDic];
        
        self.myReplyTextView.text = model.reply;
        self.moneyLabel.text = model.price;
        self.timeLabel.text = model.cycleTime;
        
    }];
}


- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)changeClick:(id)sender
{
    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"律师案件不能修改" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [aler show];
    [self netWork2];
    
    
    
    
}
/*
- (void)netWorkForChange
{
    
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
    NSDictionary *dict = @{@"cosmosPassportId":userId, @"caseTitle":@"", @"businessType":@"", @"description":self.caseDetailTextView.text, @"attachment":@"", @"districtId":@"", @"street":@"", @"lawcaseId":self.caseId};
    
    NSString*url =@"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.LC_CASE_LAWCASE_SAVE_ACTION";
    
    [NetWork POST:url parmater:dict Block:^(NSData *data) {
        if (data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"success"] intValue] == 0) {
                UIAlertView*alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"案件修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alert show];
                
            }
            else{
                NSLog(@"%@",myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"lawcaseNo"]);
                UIAlertView*alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"案件修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alert show];
                }
    
        }
    }];
}


*/







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
