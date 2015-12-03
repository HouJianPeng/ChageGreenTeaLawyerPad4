//
//  BusinessAreaTableViewController.m
//  greenTeaLawyer
//
//  Created by Herron on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BusinessAreaTableViewController.h"
#import "BusinessAreaTableViewCell.h"

#define KBusinessAreaTableViewCell   @"businessCellIdentifier"

@interface BusinessAreaTableViewController ()

@property (nonatomic, copy) NSArray *businessAreaArray;
@property (nonatomic, copy) NSArray *saixuanArray;

@end

@implementation BusinessAreaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dic1 = @{@"民商事合同诉讼与仲裁":@"G"};
    NSDictionary *dic2 = @{@"劳动争议":@"F"};
    NSDictionary *dic3 = @{@"公司法律事务":@"A"};
    NSDictionary *dic4 = @{@"房地产与建筑工程":@"D"};
    NSDictionary *dic5 = @{@"银行与金融":@"B"};
    NSDictionary *dic6 = @{@"证券与资本市场":@"R"};
    NSDictionary *dic7 = @{@"公司收购、兼并与重组":@"C"};
    NSDictionary *dic8 = @{@"私募股权与投资基金":@"J"};
    NSDictionary *dic9 = @{@"知识产权":@"E"};
    NSDictionary *dic10 = @{@"刑事案件":@"H"};

    self.businessAreaArray = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10, nil];
    self.saixuanArray = @[@"minshang", @"laodong", @"gongsiafalv", @"fangdichan", @"yinhang", @"zhengquan", @"gongsishougou", @"simu", @"zhishi", @"xinshi"];
    
    [self.tableView setBackgroundColor:[UIColor darkGrayColor]];
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessAreaTableViewCell" bundle:nil] forCellReuseIdentifier:KBusinessAreaTableViewCell];
    [self.tableView setExclusiveTouch:NO];
    self.tableView.rowHeight = 60;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.businessAreaArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KBusinessAreaTableViewCell forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView setBackgroundColor:[UIColor darkGrayColor]];
    NSDictionary *dic = [self.businessAreaArray objectAtIndex:indexPath.row];
    [cell.titleLabel setText:[[dic allKeys] firstObject]];
    [cell.titleLabel setTintColor:[UIColor whiteColor]];
    [cell.iconImageView setImage:[UIImage imageNamed:[self.saixuanArray objectAtIndex:indexPath.row]]];
    return cell;
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = [self.businessAreaArray objectAtIndex:indexPath.row];
    [self.delegate sendBusinessToCaseList:[[dic allValues] firstObject]];
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
