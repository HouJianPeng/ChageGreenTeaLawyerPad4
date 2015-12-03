//
//  RegisterViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+Validation.h"
#import "TFDatePickerView.h"
#import "ChangeSuccessViewController.h"


@interface RegisterViewController ()<UITextFieldDelegate, UIAlertViewDelegate, TFDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;     // 手机号
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;    // 验证码
@property (weak, nonatomic) IBOutlet UITextField *setupPasswordTextField;   // 设置密码
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField; // 确认密码
@property (weak, nonatomic) IBOutlet UITextField *nameTextField; // 姓名
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;  // 性别
@property (weak, nonatomic) IBOutlet UITextField *idCardTextField; // 身份证号
@property (weak, nonatomic) IBOutlet UITextField *practiceNumTextField; // 执业证号
@property (weak, nonatomic) IBOutlet UITextField *institutionTextField; // 执业机构
@property (weak, nonatomic) IBOutlet UITextField *releaseDateTextField; // 发证日期
@property (weak, nonatomic) IBOutlet UITextField *licensedTypeTextField; // 执业证类型
@property (weak, nonatomic) IBOutlet UITextField *issuingTextField; // 发证机关
@property (weak, nonatomic) IBOutlet UITextField *businessTypeTextField; // 业务领域


@property (nonatomic, retain) NSDictionary *genderDic; // 性别字典
@property (nonatomic, retain) NSDictionary *businessAreaDic; // 业务领域字典
@property (nonatomic, retain) NSDictionary *licensedTypeDic; //执业证类型字典
@property (nonatomic, retain) NSDictionary *issuingDic; //发证机关字典

@property (nonatomic, retain) NSMutableArray *businessTempArray;// 临时存放业务领域的数组
@property (nonatomic, retain) NSMutableArray *licensedTypeTempArray; //临时存放执业证类型数组
@property (nonatomic, retain) NSMutableArray *issuingTempArray; //临时存放发证机关数组

@property (nonatomic, retain) NSArray *licensedTypeArray; //执业证数组
@property (nonatomic, retain) NSArray *issuingArray; //发证机关数组
@property (nonatomic, retain) NSArray *businessArray; // 业务领域

@property (nonatomic, retain) UIAlertView *genderAlert; // 性别提示框
@property (nonatomic, retain) UIAlertView *businessAreaAlert; // 业务领域提示框
@property (nonatomic, retain) UIAlertView *businessCountAlert; // 业务领域记录提示框
@property (nonatomic, retain) UIAlertView *licensedTypeAreaAlert; //执业证类型提示框
@property (nonatomic, retain) UIAlertView *issuingAreaAlert; //发证机关提示框
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.genderTextField.delegate = self;
    self.businessTypeTextField.delegate = self;
    self.releaseDateTextField.delegate = self;
    self.issuingTextField.delegate = self; //发证机关
    self.licensedTypeTextField.delegate = self; //执业证类型
    
    self.businessTempArray = [NSMutableArray array];
    
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
    
    self.businessAreaDic = @{
                             [_businessArray objectAtIndex:0]:@"A",
                             [_businessArray objectAtIndex:1]:@"B",
                             [_businessArray objectAtIndex:2]:@"C",
                             [_businessArray objectAtIndex:3]:@"D",
                             [_businessArray objectAtIndex:4]:@"E",
                             [_businessArray objectAtIndex:5]:@"F",
                             [_businessArray objectAtIndex:6]:@"G",
                             [_businessArray objectAtIndex:7]:@"H",
                             [_businessArray objectAtIndex:8]:@"I",
                             [_businessArray objectAtIndex:9]:@"J"};
    self.genderDic = @{@"男":@"0", @"女":@"1"};
    
    self.issuingTempArray = [NSMutableArray array]; //发证机关类型
    
    self.issuingArray = @[@"北京司法局",
                          @"上海司法局",
                          @"天津司法局",
                          @"深圳司法局",
                          @"重庆司法局",
                          @"黑龙江省司法厅",
                          @"吉林省司法厅",
                          @"辽宁省司法厅",
                          @"内蒙古自治区司法厅",
                          @"河北省司法厅",
                          @"河南省司法厅",
                          @"山东省司法厅",
                          @"山西省司法厅",
                          @"陕西省司法厅",
                          @"安徽省司法厅",
                          @"江苏省司法厅",
                          @"湖北省司法厅",
                          @"湖南省司法厅",
                          @"浙江省司法厅",
                          @"江西省司法厅",
                          @"福建省司法厅",
                          @"广东省司法厅",
                          @"广西省司法厅",
                          @"海南省司法厅",
                          @"云南省司法厅",
                          @"贵州省司法厅",
                          @"四川省司法厅",
                          @"甘肃省司法厅",
                          @"青海省司法厅",
                          @"宁夏回族自治区司法厅",
                          @"新疆维吾尔自治区司法厅",
                          @"西藏自治区司法厅",
                          @"台湾地区",
                          @"香港地区",
                          @"澳门地区",
                          ];
    
    self.issuingDic = @{
                        [_issuingArray objectAtIndex:0]:@"1",
                        [_issuingArray objectAtIndex:1]:@"2",
                        [_issuingArray objectAtIndex:2]:@"3",
                        [_issuingArray objectAtIndex:3]:@"4",
                        [_issuingArray objectAtIndex:4]:@"5",
                        [_issuingArray objectAtIndex:5]:@"6",
                        [_issuingArray objectAtIndex:6]:@"7",
                        [_issuingArray objectAtIndex:7]:@"8",
                        [_issuingArray objectAtIndex:8]:@"9",
                        [_issuingArray objectAtIndex:9]:@"10",
                        [_issuingArray objectAtIndex:10]:@"11",
                        [_issuingArray objectAtIndex:11]:@"12",
                        [_issuingArray objectAtIndex:12]:@"13",
                        [_issuingArray objectAtIndex:13]:@"14",
                        [_issuingArray objectAtIndex:14]:@"15",
                        [_issuingArray objectAtIndex:15]:@"16",
                        [_issuingArray objectAtIndex:16]:@"17",
                        [_issuingArray objectAtIndex:17]:@"18",
                        [_issuingArray objectAtIndex:18]:@"19",
                        [_issuingArray objectAtIndex:19]:@"20",
                        [_issuingArray objectAtIndex:20]:@"21",
                        [_issuingArray objectAtIndex:21]:@"22",
                        [_issuingArray objectAtIndex:22]:@"23",
                        [_issuingArray objectAtIndex:23]:@"24",
                        [_issuingArray objectAtIndex:24]:@"25",
                        [_issuingArray objectAtIndex:25]:@"26",
                        [_issuingArray objectAtIndex:26]:@"27",
                        [_issuingArray objectAtIndex:27]:@"28",
                        [_issuingArray objectAtIndex:28]:@"29",
                        [_issuingArray objectAtIndex:29]:@"30",
                        [_issuingArray objectAtIndex:30]:@"31",
                        [_issuingArray objectAtIndex:31]:@"32",
                        [_issuingArray objectAtIndex:32]:@"33",
                        [_issuingArray objectAtIndex:33]:@"34",
                        [_issuingArray objectAtIndex:34]:@"35"};
    
    // 初始化执业证类型
    self.licensedTypeArray = @[@"专职律师",
                               @"兼职律师",
                               @"公司律师",
                               @"公职律师",
                               @"法律援助律师",
                               @"香港居民律师",
                               @"澳门居民律师",
                               @"台湾居民律师",
                               @"军队律师"];
    
    self.licensedTypeDic = @{[_licensedTypeArray objectAtIndex:0]:@"1",
                             [_licensedTypeArray objectAtIndex:1]:@"2",
                             [_licensedTypeArray objectAtIndex:2]:@"3",
                             [_licensedTypeArray objectAtIndex:3]:@"4",
                             [_licensedTypeArray objectAtIndex:4]:@"5",
                             [_licensedTypeArray objectAtIndex:5]:@"6",
                             [_licensedTypeArray objectAtIndex:6]:@"7",
                             [_licensedTypeArray objectAtIndex:7]:@"8",
                             [_licensedTypeArray objectAtIndex:8]:@"9"};
    
    
    [self loadBlackButton];
}

-(void)loadBlackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.genderTextField) {
        self.genderAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择性别" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        self.genderAlert.delegate = self;
        [self.genderAlert addButtonWithTitle:@"男"];
        [self.genderAlert addButtonWithTitle:@"女"];
        [self.genderAlert show];
        return NO;
    } else if (textField == self.businessTypeTextField) {
        
        if (self.businessTempArray.count < 10) {
            
            self.businessAreaAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择业务领域" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            
            for (int i = 0; i < 10; i++) {
                [self.businessAreaAlert addButtonWithTitle:[_businessArray objectAtIndex:i]];
                
            }
            [self.businessAreaAlert show];
        }
        if (self.businessTempArray.count == 10) {
            self.businessCountAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经选择了10个业务领域，是否重新选择" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [self.businessCountAlert show];
        }
        return NO;
    } else if (textField == self.releaseDateTextField) {
        TFDatePickerView *datePickerView = [TFDatePickerView tfDatePickerViewWithDatePickerMode:UIDatePickerModeDate Delegate:self];
        [datePickerView tf_show];
        return NO;
        //******************************发证机关**************************************
    }else if (textField == self.issuingTextField) {
        self.issuingAreaAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择发证机关" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        for(int i = 0; i < 35; i++ ) {
            [self.issuingAreaAlert addButtonWithTitle:[_issuingArray objectAtIndex:i]];
        }
        [self.issuingAreaAlert show];
        return NO;
        
        //******************************执业证类型************************************
    }else if (textField == self.licensedTypeTextField) {
        self.licensedTypeAreaAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择执业证" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        for(int i = 0; i < self.licensedTypeArray.count; i++ ) {
            
            [self.licensedTypeAreaAlert addButtonWithTitle:[_licensedTypeArray objectAtIndex:i]];
        }
        [self.licensedTypeAreaAlert show];
        return NO;
        
        //************************************************************************
      
    } else {
        return NO;
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.genderAlert) {
        if (buttonIndex == 0) {
            self.genderTextField.text = @"男";
        } else if (buttonIndex == 1) {
            self.genderTextField.text = @"女";
        } else {
            
        }
    }else if (alertView == self.licensedTypeAreaAlert){  //执业证提示框
        for (int i = 0; i < self.licensedTypeArray.count; i++) {
            if (buttonIndex == i) {
                self.licensedTypeTextField.text = [self.licensedTypeArray objectAtIndex:i];
            }
        }
    }else if (alertView == self.issuingAreaAlert){   //发证机关提示框
        for (int i = 0; i < self.issuingArray.count; i++) {
            if (buttonIndex == i) {
                self.issuingTextField.text = [self.issuingArray objectAtIndex:i];
            }
        }
        
    } else if (alertView == self.businessAreaAlert) {
        
        for (int i = 0; i < 10; i++) {
            
            if (buttonIndex == i) {
                
                if ([self.businessTempArray containsObject:[self.businessArray objectAtIndex:i]] == NO && self.businessTempArray.count < 2) {
                    [self.businessTempArray addObject:[_businessArray objectAtIndex:i]];
                    
                    NSString * allStr = @"";
                    for (NSString * type in self.businessTempArray) {
                        allStr = [NSString stringWithFormat:@"%@、%@",
                                  allStr,type];
                    }
                    allStr = [allStr substringFromIndex:1];
                    self.businessTypeTextField.text = allStr;
                }
            }
        }
    } else if (alertView == self.businessCountAlert) {
        if (buttonIndex == 0) {
            [self.businessTempArray removeAllObjects];
            self.businessTypeTextField.text = @"";
        }
    }
}


#pragma mark - DatePickerViewDelegate
- (BOOL)submitWithSelectedDate:(NSDate *)selectedDate
{
    NSDate *currentDate = [NSDate date];
    if ([currentDate compare:selectedDate] == NSOrderedAscending) {
        return NO;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:selectedDate];
    self.releaseDateTextField.text = dateStr;
    return YES;
}

#pragma mark - 点击获取验证码
- (IBAction)gainVerificationForCompanyClick:(id)sender {
    
    if ([self.phoneNumberTextField.text validateMobile:self.phoneNumberTextField.text]) {
        
        NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_GET_USER_INFO_BLOCK&uname=%@", SERVER_HOST_PRODUCT, self.phoneNumberTextField.text];
        
        [NetWork POST:url parmater:nil Block:^(NSData *data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSNumber *success = (NSNumber *)[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_GET_USER_INFO_BLOCK"] objectForKey:@"object"] objectForKey:@"success"];
            if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户已经存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alert.tag = 12;
                [alert show];
            }
            else {
                NSDictionary *dic = @{@"phoneNumbers":_phoneNumberTextField.text, @"content":@"【绿茶网】尊敬的用户，您在进行绿茶网的注册验证码：<vcode>，请妥善保管。", @"validateEvent":@"register"};
                
                [NetWork GET:VerificationMessageURL parmater:dic Block:^(NSData *data) {
                    
                    NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    
                    NSString *result = [[[[[myDic objectForKey:@"result"] objectForKey:@"config"] objectForKey:@"smsSender"] objectForKey:@"object"] objectForKey:@"succeed"];
                    
                    NSLog(@"succeed = %@", result);
                }];
                
                [self timeCountDownWithSender:sender];
            }
        }];
    }
}


#pragma mark - 点击立即注册
- (IBAction)registNowAction:(id)sender
{
    // 检查输入 如果输入正确就发送注册请求
    if ([self checkList]) {
        
        NSDictionary *dic = [self appendParmater];
        
        [NetWork GET:RegistURL parmater:dic Block:^(NSData *data) {
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dataDic == %@", dataDic);
            
            NSDictionary *accountDic = [[[[dataDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"CL_ACC_ACCOUNT_REGISTER_ACTION"] objectForKey:@"object"];
            
            NSString *success = [accountDic objectForKey:@"success"];
            NSLog(@"success = %@", success);
            
            NSNumber *result = (NSNumber *)success;
            if ([result isEqualToNumber:[NSNumber numberWithInt:1]]) {
                
                Account *account = [Account initAccount:accountDic];
                [AccountManager sharedInstance].account = account;
                [[AccountManager sharedInstance] saveAccountInfoToDisk];
                                
                ChangeSuccessViewController *success = [[ChangeSuccessViewController alloc] init];
                success.showStr = @"注册成功";
                [self.navigationController pushViewController:success animated:YES];
                
                
            }else if ([result isEqualToNumber:[NSNumber numberWithInt:2]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名已经存在" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码有误" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }];
    }
    
}


#pragma mark - 拼接请求参数
- (NSDictionary *)appendParmater
{
    NSString *allStr = @"";
    
    if (self.businessTempArray.count == 1) {
        allStr = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
    }
    
    if (self.businessTempArray.count == 2) {
        NSString *str1 = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
        NSString *str2 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:1]];
        allStr = [NSString stringWithFormat:@"%@,%@", str1,str2];
    }
    
    if (self.businessTempArray.count == 3) {
        NSString *str1 = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
        NSString *str2 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:1]];
        NSString *str3 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:2]];
        allStr = [NSString stringWithFormat:@"%@,%@,%@", str1,str2,str3];
    }
    if (self.businessTempArray.count == 4) {
        NSString *str1 = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
        NSString *str2 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:1]];
        NSString *str3 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:2]];
        NSString *str4 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:3]];
        allStr = [NSString stringWithFormat:@"%@,%@,%@,%@", str1,str2,str3,str4];
    }
    if (self.businessTempArray.count == 5) {
        NSString *str1 = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
        NSString *str2 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:1]];
        NSString *str3 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:2]];
        NSString *str4 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:3]];
        NSString *str5 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:4]];
        allStr = [NSString stringWithFormat:@"%@,%@,%@,%@,%@", str1,str2,str3,str4,str5];
    }
    if (self.businessTempArray.count == 6) {
        NSString *str1 = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
        NSString *str2 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:1]];
        NSString *str3 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:2]];
        NSString *str4 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:3]];
        NSString *str5 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:4]];
        NSString *str6 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:5]];
        allStr = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@", str1,str2,str3,str4,str5,str6];
    }
    if (self.businessTempArray.count == 7) {
        NSString *str1 = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
        NSString *str2 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:1]];
        NSString *str3 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:2]];
        NSString *str4 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:3]];
        NSString *str5 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:4]];
        NSString *str6 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:5]];
        NSString *str7 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:6]];
        allStr = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@", str1,str2,str3,str4,str5,str6,str7];
    }
    if (self.businessTempArray.count == 8) {
        NSString *str1 = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
        NSString *str2 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:1]];
        NSString *str3 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:2]];
        NSString *str4 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:3]];
        NSString *str5 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:4]];
        NSString *str6 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:5]];
        NSString *str7 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:6]];
        NSString *str8 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:7]];
        allStr = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@", str1,str2,str3,str4,str5,str6,str7,str8];
    }
    if (self.businessTempArray.count == 9) {
        NSString *str1 = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
        NSString *str2 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:1]];
        NSString *str3 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:2]];
        NSString *str4 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:3]];
        NSString *str5 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:4]];
        NSString *str6 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:5]];
        NSString *str7 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:6]];
        NSString *str8 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:7]];
        NSString *str9 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:8]];
        allStr = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@", str1,str2,str3,str4,str5,str6,str7,str8,str9];
    }
    if (self.businessTempArray.count == 10) {
        NSString *str1 = [self.businessAreaDic objectForKey:[self.businessTempArray firstObject]];
        NSString *str2 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:1]];
        NSString *str3 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:2]];
        NSString *str4 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:3]];
        NSString *str5 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:4]];
        NSString *str6 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:5]];
        NSString *str7 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:6]];
        NSString *str8 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:7]];
        NSString *str9 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:8]];
        NSString *str10 = [self.businessAreaDic objectForKey:[self.businessTempArray objectAtIndex:9]];
        allStr = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@", str1,str2,str3,str4,str5,str6,str7,str8,str9,str10];
    }

    NSDictionary *extensionsDic =@{
                                   @"accountType":@"lawyer",
                                   @"certificateNumber":self.practiceNumTextField.text,
                                   @"institution":self.institutionTextField.text,
                                   //@"certificateDate":self.releaseDateTextField.text,
                                   @"certificateDate":[self.licensedTypeDic valueForKey:self.licensedTypeTextField.text],
                                   @"certificateType":self.licensedTypeTextField.text,
                                   @"idCard":self.idCardTextField.text,
                                   //@"issuingAuthority":self.issuingTextField.text,
                                   @"issuingAuthority":[self.issuingDic valueForKey:self.issuingTextField.text],
                                   @"businessArea":allStr};
    
    NSString *extensionsStr = [self transformWithDictionary:extensionsDic];
    
    NSDictionary *parmater = @{@"mcode":self.verificationTextField.text,
                               @"gender":[self.genderDic objectForKey:self.genderTextField.text],
                               @"validateEvent":@"register",
                               @"validateObject":self.phoneNumberTextField.text,
                               @"validateType":@"mobile",
                               @"userName":self.phoneNumberTextField.text,
                               @"realName":self.nameTextField.text,
                               @"userType":@"lawyer",
                               @"mobile":self.phoneNumberTextField.text,
                               @"userPassword":self.setupPasswordTextField.text,
                               @"isMobileChecked":@"true",
                               @"exts":@"{}",
                               @"locked":@"false",
                               @"login":@"true",
                               @"extensions":extensionsStr};
    return parmater;
}


#pragma mark - 将字典转换成扩展字符串
- (NSString *)transformWithDictionary:(NSDictionary *)dic
{
    NSMutableString *string = [[NSMutableString alloc] init];
    for (NSString *key in dic) {
        NSString *str = [NSString stringWithFormat:@"%@<paramValue>%@<paramSplit>", key, [dic objectForKey:key]];
        [string appendString:str];
    }
    
    return string;
}


#pragma mark - 检查输入
- (BOOL)checkList
{
    if ([self.phoneNumberTextField.text length] == 0) {
        [self showAlertWithTitle:@"请输入用户名" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.verificationTextField.text length] == 0) {
        [self showAlertWithTitle:@"请输入验证码" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.setupPasswordTextField.text length] == 0) {
        [self showAlertWithTitle:@"请输入密码" cancelButtonTitle:@"确定"];
        return NO;
    }else if (![self.setupPasswordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        [self showAlertWithTitle:@"两次密码输入不一致" cancelButtonTitle:@"确定"];
        return NO;
    }else if ([self.nameTextField.text length] == 0) {
        [self showAlertWithTitle:@"请输入姓名" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.genderTextField.text length] == 0) {
        [self showAlertWithTitle:@"请选择性别" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.idCardTextField.text length] != 18) {
        [self showAlertWithTitle:@"请输入正确身份证号" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.practiceNumTextField.text length] == 0) {
        [self showAlertWithTitle:@"请输入执业证号" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.institutionTextField.text length] == 0) {
        [self showAlertWithTitle:@"请输入执业机构" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.releaseDateTextField.text length] == 0) {
        [self showAlertWithTitle:@"请输入发证日期" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.licensedTypeTextField.text length] == 0) {
        [self showAlertWithTitle:@"请选择执业证类型" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.issuingTextField.text length] == 0) {
        [self showAlertWithTitle:@"请选择发证机关" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.businessTypeTextField.text length] == 0) {
        [self showAlertWithTitle:@"请选择业务领域" cancelButtonTitle:@"确定"];
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - 提示框
- (void)showAlertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark - 返回
- (void)doBack:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 倒计时
- (void)timeCountDownWithSender:(UIButton *)sender
{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                sender.userInteractionEnabled = YES;
                sender.backgroundColor = [UIColor lightGrayColor];
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d秒后重发", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.userInteractionEnabled = NO;
                sender.backgroundColor = [UIColor lightGrayColor];
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
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
