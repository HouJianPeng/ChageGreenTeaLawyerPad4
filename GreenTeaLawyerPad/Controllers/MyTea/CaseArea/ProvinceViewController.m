//
//  ProvinceViewController.m
//  greenTeaUser
//
//  Created by mac on 15/7/15.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "ProvinceViewController.h"
#import "ProviceTableViewCell.h"
#import "CityViewController.h"

@interface ProvinceViewController()<UITableViewDataSource,UITableViewDelegate,CityViewControllerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *provinceTableView;
@property (nonatomic, strong) NSMutableArray *caseProvinceArray;
@property(nonatomic,strong)NSMutableDictionary*provinceDic;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property(nonatomic,strong)NSString *cityId;
@property(nonatomic,strong)NSString *provubceId;
@property(nonatomic,strong)NSString *areaId;


@end

@implementation ProvinceViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"省";
    [self loadBlackButton];
    self.provinceTableView.dataSource = self;
    self.provinceTableView.delegate = self;
    [self GetProvince];
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
-(void)GetProvince{
    self.caseProvinceArray =[@[]mutableCopy];
    self.provinceDic =[@{} mutableCopy];
    NSString*url =@"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.SC_DIS_DISTRICT_CHILDREN";
    NSDictionary*province = @{@"districtCode":@"353000000000"};
    [NetWork POST:url parmater:province Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray*array =myDic[@"result"][@"scommerce"][@"SC_DIS_DISTRICT_CHILDREN"][@"list"];
        for (NSArray*tha in array) {
            for (NSDictionary*dic in tha) {
                NSString*theproVice =[ NSString stringWithFormat:@"%@", dic[@"label"]];
                [self.caseProvinceArray addObject:theproVice];
                [self.provinceDic setObject:dic[@"id"]forKey:theproVice];
            }
        }
        [self.provinceTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return self.caseProvinceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellindetifier = @"ProviceTableViewCell";
    ProviceTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellindetifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellindetifier owner:nil options:nil] firstObject];
    }
    cell.theproviceLabel.text =self.caseProvinceArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.caseProvinceArray[indexPath.row]);
    NSLog(@"%@",self.provinceDic[self.caseProvinceArray[indexPath.row]]);
    CityViewController*city = [[CityViewController alloc] init];
    city.title = self.caseProvinceArray[indexPath.row];
    city.delegate = self;
    city.cityId = self.provinceDic[self.caseProvinceArray[indexPath.row]];
    [self.navigationController pushViewController:city animated:YES];
}
-(void)getThecity:(NSMutableArray *)array withProviceId:(NSString *)proviceId CityId:(NSString *)cityId withAreaID:(NSString *)areaID{
    self.cityArray = array;
    self.provubceId = proviceId;
    self.cityId = cityId;
    self.areaId = areaID;
    NSLog(@"%@",array[0]);
    NSString*str = array[0];
    UIAlertView*alert =[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    alert.delegate = self;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.delegate pushTheProvince:self.cityArray withProVinceID:self.provubceId withCityID:self.cityId andAreaId:self.areaId];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


@end
