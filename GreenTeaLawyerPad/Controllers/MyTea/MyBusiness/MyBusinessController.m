//
//  MyBusinessController.m
//  GreenTeaLawyerPad
//
//  Created by 侯建鹏 on 15/11/18.
//  Copyright © 2015年 BeiJingYuntai. All rights reserved.
//

#import "MyBusinessController.h"
#import "InfoViewController.h"
#import "BasicInfoViewController.h"

@interface MyBusinessController ()<UITextFieldDelegate>

@end

@implementation MyBusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.myBusinessStr);
    self.dic = @{@"A":@"公司法律事务",
                 @"B":@"银行与金融",
                 @"C":@"公司收购、兼并与重组",
                 @"D":@"房地产与建筑工程",
                 @"E":@"知识产权",
                 @"F":@"劳动争议",
                 @"G":@"民商事合同诉讼与仲裁",
                 @"H":@"刑事案件",
                 @"I":@"证券与资本市场",
                 @"J":@"私募股权与投资基金",
                 };
    NSString * resultString ;
    NSArray * array = [self.myBusinessStr componentsSeparatedByString:@","];
    for (NSString * st in array) {
        NSString * dic = self.dic[st];
        if (resultString) {
            resultString = [NSString stringWithFormat:@"%@/%@",resultString,dic];
        }
        else{
            resultString = [NSString stringWithFormat:@"%@",dic];
        }
    }
    self.title = @"我的领域";
    self.myBusines.text = resultString;
    
    [self setLeftBtn];
    [self network];
}
- (void)network{
    
    
    
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
