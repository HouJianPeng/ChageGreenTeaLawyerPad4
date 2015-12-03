//
//  InfoViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "InfoViewController.h"
#import "ChangeEmailViewController.h"
#import "NetWorkMacro.h"
#define kContentScrollerViewHeight self.contentScrollView.frame.size.height
#define SERVER_HOST_PRODUCT_Info  @"http://www.lawcheck.com.cn"
@interface InfoViewController ()<UIScrollViewDelegate, BasicInfoViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray *infoArray;
@property (nonatomic, retain) NSMutableArray *idCardArray;

@property (nonatomic, retain) NSArray *businessArray;
@property (nonatomic, retain) NSDictionary *businessAreaDic;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.infoArray = [NSMutableArray array];
    self.idCardArray = [NSMutableArray array];

    self.businessArray = @[@"公司法律事务",
                           @"银行与金融",
                           @"公司收购、兼并与重组",
                           @"房地产与建筑工程",
                           @"知识产权",
                           @"劳动争议",
                           @"民商事合同诉讼与仲裁",
                           @"刑事案件",
                           @"证券与资本市场",
                           @"私募股权与投资基金"];
    
    self.businessAreaDic = @{[_businessArray objectAtIndex:0]:@"A",
                             [_businessArray objectAtIndex:1]:@"B",
                             [_businessArray objectAtIndex:2]:@"C",
                             [_businessArray objectAtIndex:3]:@"D",
                             [_businessArray objectAtIndex:4]:@"E",
                             [_businessArray objectAtIndex:5]:@"F",
                             [_businessArray objectAtIndex:6]:@"G",
                             [_businessArray objectAtIndex:7]:@"H",
                             [_businessArray objectAtIndex:8]:@"I",
                             [_businessArray objectAtIndex:9]:@"J"};
    
    
    self.infoArray = [NSMutableArray array];
    self.idCardArray = [NSMutableArray array];

    self.title = @"资料完善";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    //设置scrollView
    self.contentScrollView.contentSize = CGSizeMake(kScreenBoundWidth * 2, 0);
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    self.contentScrollView.scrollEnabled = NO;
    self.contentScrollView.delegate = self;
    [self netWork];
    
}


- (void)netWork
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_ACCOUNT_GET&userId=%@",SERVER_HOST_PRODUCT, userId];
    
    [NetWork POST:url parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSDictionary *infoDic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_ACCOUNT_GET"] objectForKey:@"list"] firstObject] firstObject];
        NSLog(@"infoDic = %@", infoDic);
        
        Account *account = [Account initAccount:infoDic];
        if ([account.gender isEqualToString:@"1"]) {
            account.gender = @"女";
        } else {
            account.gender = @"男";
        }
        
        [AccountManager sharedInstance].account.provinceID =account.provinceID;
        [AccountManager sharedInstance].account.cityID =account.cityID;
        [AccountManager sharedInstance].account.areaID =account.areaID;
        
        
        
        
        if ([account.certificateType isEqualToString:@"1"]) {
            account.certificateType = @"专职律师";
        }else if ([account.certificateType isEqualToString:@"2"]) {
            account.certificateType = @"兼职律师";
        }else if ([account.certificateType isEqualToString:@"3"]) {
            account.certificateType = @"公司律师";
        }else if ([account.certificateType isEqualToString:@"4"]) {
            account.certificateType = @"公职律师";
        }else if ([account.certificateType isEqualToString:@"5"]) {
            account.certificateType = @"法律援助律师";
        }else if ([account.certificateType isEqualToString:@"6"]) {
            account.certificateType = @"香港居民律师";
        }else if ([account.certificateType isEqualToString:@"7"]) {
            account.certificateType = @"澳门居民律师";
        }else if ([account.certificateType isEqualToString:@"8"]) {
            account.certificateType = @"台湾居民律师";
        }else if ([account.certificateType isEqualToString:@"9"]) {
            account.certificateType = @"军队律师";
        }
        
        if ([account.issuingAuthority isEqualToString:@"1"]) {
            account.issuingAuthority = @"北京司法局";
        }else if ([account.issuingAuthority isEqualToString:@"2"]) {
            account.issuingAuthority = @"上海司法局";
        }else if ([account.issuingAuthority isEqualToString:@"3"]) {
            account.issuingAuthority = @"天津司法局";
        }else if ([account.issuingAuthority isEqualToString:@"4"]) {
            account.issuingAuthority = @"深圳司法局";
        }else if ([account.issuingAuthority isEqualToString:@"5"]) {
            account.issuingAuthority = @"重庆司法局";
        }else if ([account.issuingAuthority isEqualToString:@"6"]) {
            account.issuingAuthority = @"黑龙江省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"7"]) {
            account.issuingAuthority = @"吉林省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"8"]) {
            account.issuingAuthority = @"辽宁省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"9"]) {
            account.issuingAuthority = @"内蒙古自治区司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"10"]) {
            account.issuingAuthority = @"河北省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"11"]) {
            account.issuingAuthority = @"河南省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"12"]) {
            account.issuingAuthority = @"山东省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"13"]) {
            account.issuingAuthority = @"山西省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"14"]) {
            account.issuingAuthority = @"陕西省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"15"]) {
            account.issuingAuthority = @"安徽省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"16"]) {
            account.issuingAuthority = @"江苏省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"17"]) {
            account.issuingAuthority = @"湖北省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"18"]) {
            account.issuingAuthority = @"湖南省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"19"]) {
            account.issuingAuthority = @"浙江省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"20"]) {
            account.issuingAuthority = @"江西省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"21"]) {
            account.issuingAuthority = @"福建省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"22"]) {
            account.issuingAuthority = @"广东省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"23"]) {
            account.issuingAuthority = @"广西省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"24"]) {
            account.issuingAuthority = @"海南省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"25"]) {
            account.issuingAuthority = @"云南省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"26"]) {
            account.issuingAuthority = @"贵州省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"27"]) {
            account.issuingAuthority = @"四川省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"28"]) {
            account.issuingAuthority = @"甘肃省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"29"]) {
            account.issuingAuthority = @"青海省司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"30"]) {
            account.issuingAuthority = @"宁夏回族自治区司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"31"]) {
            account.issuingAuthority = @"新疆维吾尔自治区司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"32"]) {
            account.issuingAuthority = @"西藏自治区司法厅";
        }else if ([account.issuingAuthority isEqualToString:@"33"]) {
            account.issuingAuthority = @"台湾地区";
        }else if ([account.issuingAuthority isEqualToString:@"34"]) {
            account.issuingAuthority = @"香港地区";
        }else if ([account.issuingAuthority isEqualToString:@"35"]) {
            account.issuingAuthority = @"澳门地区";
        }
        
        
        
        
        self.infoArray = [NSMutableArray arrayWithObjects:account.userName, account.displayName, account.gender, account.idCard, account.businessArea, account.address, account.certificateNumber, account.institution, account.certificateType, account.issuingAuthority, account.certificateDate, account.email, nil];
        
        //account.businessArea
        if ([account.idCardPicUrl length] != 0) {
            [self.idCardArray addObject:account.idCardPicUrl];
        } else {
            [self.idCardArray addObject:@"idcard1"];
        }
        if ([account.idCardReversePicUrl length] != 0) {
            [self.idCardArray addObject:account.idCardReversePicUrl];
        } else {
            [self.idCardArray addObject:@"idcard2"];
        }
        if ([account.idCardHandPicUrl length] != 0) {
            [self.idCardArray addObject:account.idCardHandPicUrl];
        } else {
            [self.idCardArray addObject:@"idcard2"];
        }
        if ([account.certificatePicUrl length] != 0) {
            [self.idCardArray addObject:account.certificatePicUrl];
        } else {
            [self.idCardArray addObject:@"idcard3"];
        }
        
        NSLog(@"%@", self.idCardArray);
        
        //将二个页面添加到ContentScrollView上面
        self.infoVC = [[BasicInfoViewController alloc] init];
        self.infoVC.infoArray = self.infoArray;
        self.infoVC.view.frame = CGRectMake(kScreenBoundWidth * 0, 0, kScreenBoundWidth, kContentScrollerViewHeight);
        self.infoVC.delegate = self;
        [self.contentScrollView addSubview:self.infoVC.view];
        self.certicateVC = [[CertificateViewController alloc] init];
        self.certicateVC.idCardArray = self.idCardArray;
        self.certicateVC.view.frame = CGRectMake(kScreenBoundWidth * 1, 0, kScreenBoundWidth, kContentScrollerViewHeight);
        self.certicateVC.certDelegate = self;
        [self.contentScrollView addSubview:self.certicateVC.view];
        
        self.certicateVC.automaticallyAdjustsScrollViewInsets = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        
        NSLog(@"%@", self.infoArray);
        
    }];
    
}

- (void)viewWillLayoutSubviews {
    self.infoVC.view.frame = CGRectMake(kScreenBoundWidth * 0, 0, kScreenBoundWidth, kContentScrollerViewHeight);
    self.certicateVC.view.frame = CGRectMake(kScreenBoundWidth * 1, 0, kScreenBoundWidth, kContentScrollerViewHeight);
}


#pragma mark - 基本资料
- (IBAction)basicInfoBtn:(id)sender
{
    NSLog(@"基本资料");
    [self.basicInfo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.certificate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
    } completion:^(BOOL finished) {
        
    }];
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    
}


#pragma mark - 相关证件
- (IBAction)certificateBtn:(id)sender
{
    NSLog(@"相关证件");
    [self.basicInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.certificate setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
    } completion:^(BOOL finished) {
        
    }];
    self.contentScrollView.contentOffset = CGPointMake(kScreenBoundWidth, 0);
}


#pragma mark - BasicInfoViewControllerDelegate
- (void)intoPushToViewController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)sendToInfoWithMessage:(NSString *)message
{
    [self.infoArray replaceObjectAtIndex:self.infoArray.count - 1 withObject:message];
}


#pragma mark - 返回
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
