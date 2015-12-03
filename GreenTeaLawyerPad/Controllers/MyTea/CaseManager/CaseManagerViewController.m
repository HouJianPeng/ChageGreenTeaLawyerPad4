//
//  CaseManagerViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/23.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import "NetWork.h"
#import "NetWorkMacro.h"
#import "Account.h"
#import "AccountManager.h"
#import "CaseManager.h"
#import "CaseManagerViewController.h"
#import "CaseManagerTableViewCell.h"
#import "CaseModel.h"
#import "CaseManager.h"
#import "InCaseViewController.h"
#import "InCaseViewController.h"
#import "MJRefresh.h"
@interface CaseManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *theCaseManagerTableView;
@property (nonatomic, strong) NSMutableArray *caseArray;
@end
static NSInteger page = 1;
@implementation CaseManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"案件管理";
    [self loadBlackButton];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.theCaseManagerTableView.delegate = self;
    self.theCaseManagerTableView.dataSource = self;
    [self network];
    __block  CaseManagerViewController *weakSelf = self;
    self.theCaseManagerTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self.theCaseManagerTableView.footer beginRefreshing];
            if (self.caseArray.count==10) {
                  page++;
            }
            [weakSelf network];
            [self.theCaseManagerTableView.footer endRefreshing];
    }];
    self.theCaseManagerTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.theCaseManagerTableView.header beginRefreshing];
        page = 1;
        [weakSelf network];
        [self.theCaseManagerTableView.header endRefreshing];
    }];
//    self.theCaseManagerTableView.footer = [mjrefreshb]
    // Do any additional setup after loading the view from its nib.
}
- (void)network
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    NSString *url = [NSString stringWithFormat:@"http://www.lawcheck.com.cn//cosmos.json?command=scommerce.LC_CASE_LAWCASE_LIST4USER_BLOCK&cosmosPassportId=%@&keywords=%@&page=%ld&pageSize=%@",userId,@"",page,@"10"];
    
    [NetWork GET:url parmater:nil Block:^(NSData *data) {
        
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSArray *array = [[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWCASE_LIST4USER_BLOCK"] objectForKey:@"list"] firstObject];
        self.caseArray = [@[] mutableCopy];
        for (NSDictionary *dic in array) {
            CaseModel *caseModel = [CaseManager caseModelWithDict:dic];
            
            [self.caseArray addObject:caseModel];
        }
        NSLog(@"%@", self.caseArray);
        [self.theCaseManagerTableView reloadData];
        
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.caseArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIndentifier =@"CaseManagerTableViewCell";
    CaseManagerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIndentifier owner:nil options:nil] firstObject];
    }
     CaseModel *model = [self.caseArray objectAtIndex:indexPath.section];
    [cell.theDetialButton addTarget:self action:@selector(pushTheDetialView:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.theTypeCase.text = model.statusLabel;
    cell.thaCaseNumber.text = model.caseNo;
    cell.theCaseType.text = model.businessTypeLabel;
    cell.theCaseTitle.text = model.caseTitle;
    cell.theDetialButton.tag = indexPath.section+100;
    return cell;
}

-(void)pushTheDetialView:(UIButton*)tap{
    CaseModel *model = [self.caseArray objectAtIndex:tap.tag-100];
    InCaseViewController *incaseVC = [[InCaseViewController alloc]init];
    incaseVC.caseId = model.caseId;
    incaseVC.caseTitle = model.caseTitle;
    incaseVC.caseNumber = model.caseNo;
    incaseVC.caseType = model.businessTypeLabel;
    incaseVC.caseDetail = model.descriptionStr;
    incaseVC.caseState = model.statusLabel;
    [self.navigationController pushViewController:incaseVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.caseArray.count==0) {
        return [UIScreen mainScreen].bounds.size.height;
    }
    else{
    return 200;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
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
