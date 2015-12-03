//
//  BasicInfoViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/16.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "BasicInfoViewController.h"
#import "PersonTableViewCell.h"
#import "ChangeEmailViewController.h"
#import "MyBusinessController.h"
#import "ProvinceViewController.h"
#import "ChangeAreaController.h"

@interface BasicInfoViewController ()<UITableViewDelegate,UITableViewDataSource, ChangeEmailViewControllerDelegate,ChangeAreaViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *theDetialTableView;
@property(nonatomic,retain) NSArray *array;

@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theDetialTableView.delegate = self;
    self.theDetialTableView.dataSource = self;
    self.navigationController.navigationBar.hidden= YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _theDetialTableView.tableFooterView = [[UIView alloc]init];
    
    self.array = @[@"用户名",@"姓名",@"性别",@"身份证号",@"业务领域",@"所在区域",@"职业证号",@"职业机构",@"执业证类型",@"发证机关",@"执业起始日期",@"邮箱地址"];
    
    NSLog(@"self.array = %@", self.array);
    [self.theDetialTableView reloadData];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString*cellidentifer = @"PersonTableViewCell";
    PersonTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellidentifer owner:nil options:nil ] firstObject];
    }
    cell.theDescriptionLabel.text = self.array[indexPath.row];
    if (indexPath.row==4) {
        cell.theDetialLabel.text = @">";
    }
    else{
        cell.theDetialLabel.text = self.infoArray[indexPath.row] ;
    }
    
    return  cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.infoArray.count - 1) {
        ChangeEmailViewController *emailVC = [[ChangeEmailViewController alloc] init];
        emailVC.emailStr = [self.infoArray lastObject];
        emailVC.delegate = self;
        [self.delegate intoPushToViewController:emailVC];
    }
    
    if (indexPath.row == self.infoArray.count - 8) {
        MyBusinessController *myVC = [[MyBusinessController alloc]init];
        myVC.myBusinessStr = [self.infoArray objectAtIndex:4];
        
        [self.delegate intoPushToViewController:myVC];
    }
    if (indexPath.row == self.infoArray.count - 7) {
        ChangeAreaController *changeVC = [[ChangeAreaController alloc]init];
        changeVC.areaStr = [self.infoArray objectAtIndex:5];
        changeVC.delegate = self;
        [self.delegate intoPushToViewController:changeVC];
    }
}


#pragma mark - ChangeEmailViewControllerDelegate
- (void)sendToBasicInfoWithMessage:(NSString *)message
{
    [self.infoArray replaceObjectAtIndex:self.infoArray.count - 1 withObject:message];
    [self.theDetialTableView reloadData];
}
#pragma mark - ChangeAreaViewControllerDelegate
- (void)sendToInfoWithMessage:(NSString *)message
{
    NSString *string = message;
    [self.infoArray replaceObjectAtIndex:self.infoArray.count - 7 withObject:string];
    [self.theDetialTableView reloadData];
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
