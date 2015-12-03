//
//  ApplyCaseViewController.m
//  greenTeaLawyer
//
//  Created by Herron on 15/7/12.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "ApplyCaseViewController.h"
#import "ApplyCaseSuccessViewController.h"
#import "NetWork.h"
#import "NetWorkMacro.h"
#import "AccountManager.h"

@interface ApplyCaseViewController ()

@property (nonatomic, copy) NSString *assetId;

@end

@implementation ApplyCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"案件委托";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.caseDescriptionTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.caseDescriptionTextView.layer.borderWidth = 0.5;
    self.caseDescriptionTextView.layer.cornerRadius = 5;
    self.caseDescriptionTextView.layer.masksToBounds = YES;
    [self.commissionTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.executionTimeTextField setBorderStyle:UITextBorderStyleRoundedRect];
//    [self.successCaseTextField setBorderStyle:UITextBorderStyleRoundedRect];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)upLoadClick:(id)sender {
    
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        
//        [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *assetId, NSString *fileName, NSString *fileUrl) {
//            // 上传成功逻辑
//            [self.attachmentTextField setText:fileName];
//            self.assetId = assetId;
//        } failure:^(NSString *message) {
//            // 上传失败逻辑
//            NSLog(@"message = %@", message);
//        }];
        [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath RelPathEnum:RelPathResponse success:^(NSString *assetId, NSString *fileName, NSString *fileUrl) {
            // 上传成功逻辑
            [self.attachmentTextField setText:fileName];
            self.assetId = assetId;
        } failure:^(NSString *message) {
            // 上传失败逻辑
            NSLog(@"message = %@", message);
        }];
    }];
}



- (IBAction)applyCaseClick:(id)sender
{
    
    if ([self checkInput]) {
        
        NSString *userId = [AccountManager sharedInstance].account.userId;
        
        NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_CASE_LAWYERCASE_SAVE_ACTION&cosmosPassportId=%@&lawcaseId=%@&reply=%@&price=%@&cycleTime=%@&attachment=%@", SERVER_HOST_PRODUCT, userId, self.caseId, self.caseDescriptionTextView.text, self.commissionTextField.text, self.executionTimeTextField.text, self.assetId];
        
        NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"url = %@", url);
        
        [NetWork POST:urlString parmater:nil Block:^(NSData *data) {
            
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", myDic);
            
            NSDictionary *dic = [[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWYERCASE_SAVE_ACTION"] objectForKey:@"object"];
            NSString *resultStr = [dic objectForKey:@"success"];

            if ([resultStr intValue] == 1) {
                ApplyCaseSuccessViewController *applyCaseSuccessVC = [[ApplyCaseSuccessViewController alloc] init];
                [self.navigationController pushViewController:applyCaseSuccessVC animated:YES];
            } else {
//                NSString *infoStr = [dic objectForKey:@"info"];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接案失败" message:infoStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
                ApplyCaseSuccessViewController *applyCaseSuccessVC = [[ApplyCaseSuccessViewController alloc] init];
                [self.navigationController pushViewController:applyCaseSuccessVC animated:YES];
            }
        }];        
    }
}



- (BOOL)checkInput
{
    if ([self.caseDescriptionTextView.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入案例描述" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if ([self.commissionTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入期望佣金" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if ([self.executionTimeTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入执行时间" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

        return NO;
    }
    else {
        return YES;
    }
}



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
