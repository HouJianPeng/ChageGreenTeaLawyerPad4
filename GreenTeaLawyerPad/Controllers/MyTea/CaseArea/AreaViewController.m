//
//  AreaViewController.m
//  greenTeaUser
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "AreaViewController.h"
#import "ProviceTableViewCell.h"

@interface AreaViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *areaTableView;
@property(nonatomic,retain)NSMutableArray*areaArray;
@property(nonatomic,retain)NSMutableDictionary*areaDic;
@property(nonatomic,strong)NSString * cityId;
@end

@implementation AreaViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [self loadBlackButton];
    [super viewDidLoad];
    [self getTheCity];
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
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
    self.areaDic=[@{}mutableCopy];
    self.areaArray = [@[] mutableCopy];
    NSString*url = [NSString stringWithFormat:@"%@scommerce.SC_DIS_DISTRICT_CHILDREN", SERVER_HOST_PRODUCT];
    NSDictionary*city = @{@"districtId":self.areaString};
    [NetWork POST:url parmater:city Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray*array =myDic[@"result"][@"scommerce"][@"SC_DIS_DISTRICT_CHILDREN"][@"list"];
        for (NSArray*tha in array) {
            NSLog(@"%@",tha);
            for (NSDictionary*dic in tha) {
                NSString*theproVice =[ NSString stringWithFormat:@"%@", dic[@"label"]];
                NSLog(@"%@--%@",theproVice,dic[@"id"]);
                [self.areaArray addObject:theproVice];
                [self.areaDic setObject:dic[@"id"] forKey:theproVice];}
        }
        if (self.areaArray.count) {
               [self.areaTableView reloadData];
        }
        else{
            [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"没有更详细地址信息" cancelButtonTitle:@"返回" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                NSMutableArray*array = [NSMutableArray arrayWithCapacity:0];
                [array addObject:self.title];
                [self.delegate getThearea:array withcityID:self.areaString withArea:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
     
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
    return self.areaArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellindenifier =@"ProviceTableViewCell";
    ProviceTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellindenifier];
    if (!cell) {
        cell  = [[[NSBundle mainBundle] loadNibNamed:cellindenifier owner:nil options:nil] firstObject];
    }
    cell.theproviceLabel.text =self.areaArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray*array = [@[]mutableCopy];
    NSString*select = [NSString stringWithFormat:@"%@ %@",self.title,self.areaArray[indexPath.row]];
    
    [array addObject:select];
    NSLog(@"%@",self.areaDic);
    [array addObject:self.areaDic[self.areaArray[indexPath.row]]];
    [self.delegate getThearea:array withcityID:self.areaString withArea:[array lastObject]];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
