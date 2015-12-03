//
//  ChangeAreaController.m
//  GreenTeaLawyerPad
//
//  Created by 侯建鹏 on 15/11/18.
//  Copyright © 2015年 BeiJingYuntai. All rights reserved.
//

#import "ChangeAreaController.h"
#import "ZHPickView.h"
#import "ProvinceViewController.h"
@interface ChangeAreaController ()<ZHPickViewDelegate,UITextFieldDelegate,UITextViewDelegate,ProvinceViewControllerDelegate>

@property (weak, nonatomic) NSString *districtId;
@property (strong, nonatomic)ZHPickView *pickViewTwo;
@property (nonatomic, retain) NSDictionary *dict;// 参数字典
@property(nonatomic,strong)NSString * proviceId;
@property(nonatomic,strong)NSString * cityId;
@property(nonatomic,strong)NSString * areaId;
@end

@implementation ChangeAreaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"修改地区";
    [self setLeftBtn];
    self.businessType.delegate = self;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    //[rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    //[rightBtn addTarget:self action:@selector(upLoadArea:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.businessType.text = self.areaStr;
    self.proviceId =  [AccountManager sharedInstance].account.provinceID ;
    self.cityId =  [AccountManager sharedInstance].account.cityID ;
    self.areaId = [AccountManager sharedInstance].account.areaID;
}

- (void)doBack:(UIButton *)sender
{
    [self.pickViewTwo remove];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark选择的省市

-(void)pushTheProvince:(NSMutableArray *)array withProVinceID:(NSString *)prienceID withCityID:(NSString *)cityID andAreaId:(NSString *)areaId{
    self.businessType.text = array[0];
    self.proviceId = prienceID;
    self.cityId = cityID;
    self.areaId = areaId;
}

#pragma mark 省份选择
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.businessType) {
        [self.view endEditing:YES];
        [self.pickViewTwo remove];
        ProvinceViewController * provice = [[ProvinceViewController alloc] init];
        provice.delegate = self;
        [self.navigationController pushViewController:provice animated:YES];
        return NO;
    }else{
        [self.pickViewTwo remove];
        return YES;
    }
}

//- (void)upLoadArea:(UIButton *)sender
//{
//    
//    [self networkForUpdateAdress];
//    [self.delegate sendToInfoWithMessage:self.businessType.text];
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)networkForUpdateAdress{
    
    NSString *userId = [AccountManager sharedInstance].account.userId;
    NSDictionary *dic = @{@"userId":userId, @"province":self.proviceId, @"city":self.cityId, @"district":self.areaId};
    [NetWork POST:ChangAdressURL parmater:dic Block:^(NSData *data) {
        
    }];
    
}

@end
