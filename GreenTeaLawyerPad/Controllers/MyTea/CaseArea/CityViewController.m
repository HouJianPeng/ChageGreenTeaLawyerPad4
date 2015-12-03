//
//  CityViewController.m
//  greenTeaUser
//
//  Created by mac on 15/7/15.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "CityViewController.h"
#import "ProviceTableViewCell.h"
#import "AreaViewController.h"
@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate,AreaTheAreaViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *thecityTableView;
@property (nonatomic, strong) NSMutableArray *caseCityArray;
@property(nonatomic,strong)NSMutableDictionary*cityDic;
@end

@implementation CityViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBlackButton];
    [self getTheCity];
    self.thecityTableView.dataSource = self;
    self.thecityTableView.delegate = self;
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
-(void)getTheCity{
    self.cityDic=[@{}mutableCopy];
    self.caseCityArray = [@[] mutableCopy];
    NSString*url = [NSString stringWithFormat:@"%@scommerce.SC_DIS_DISTRICT_CHILDREN", SERVER_HOST_PRODUCT];
    NSDictionary*city = @{@"districtId":self.cityId};
    [NetWork POST:url parmater:city Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray*array =myDic[@"result"][@"scommerce"][@"SC_DIS_DISTRICT_CHILDREN"][@"list"];
        for (NSArray*tha in array) {
            NSLog(@"%@",tha);
            for (NSDictionary*dic in tha) {
                            NSString*theproVice =[ NSString stringWithFormat:@"%@", dic[@"label"]];
                            NSLog(@"%@",theproVice);
                            [self.caseCityArray addObject:theproVice];
                            [self.cityDic setObject:dic[@"id"] forKey:theproVice];}
        }
        [self.thecityTableView reloadData];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.caseCityArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellindetifier = @"ProviceTableViewCell";
    ProviceTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellindetifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellindetifier owner:nil options:nil] firstObject];
    }
     cell.theproviceLabel.text =self.caseCityArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.caseCityArray[indexPath.row]);
    NSLog(@"%@",self.cityDic[self.caseCityArray[indexPath.row]]);
    AreaViewController*area = [[AreaViewController alloc] init];
    area.title =self.caseCityArray[indexPath.row];
    area.areaString = self.cityDic[self.caseCityArray[indexPath.row]];
    area.delegate = self;
    [self.navigationController pushViewController:area animated:YES];

}
-(void)getThearea:(NSMutableArray *)array withcityID:(NSString *)cityId withArea:(NSString *)areaID{
    if (array.count==1){
        
        NSMutableArray*tharray = [@[] mutableCopy];
        NSString*str = [NSString stringWithFormat:@"%@ %@",self.title,array[0]];
        [tharray addObject:str];
        [tharray addObject:self.cityDic[array[0]]];
        //        [self.delegate getThecity:tharray];
        [self.delegate getThecity:tharray withProviceId:self.cityId CityId:cityId withAreaID:areaID];
    }
    else{
        
        NSMutableArray*tarray = [@[] mutableCopy];
        NSString*select = [NSString stringWithFormat:@"%@ %@",self.title,array[0]];
        [tarray addObject:select];
        [tarray addObject:array[1]];
        [self.delegate getThecity:tarray withProviceId:self.cityId CityId:cityId withAreaID:areaID];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
