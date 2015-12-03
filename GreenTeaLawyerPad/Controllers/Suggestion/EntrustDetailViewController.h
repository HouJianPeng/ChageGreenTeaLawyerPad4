//
//  EntrustDetailViewController.h
//  greenTeaLawyer
//
//  Created by Herron on 15/7/12.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntrustDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *caseTitleTextField;//标题
@property (weak, nonatomic) IBOutlet UILabel *caseTimeTextField;//发布时间
@property (weak, nonatomic) IBOutlet UILabel *casePersonTextField;//发布人
@property (weak, nonatomic) IBOutlet UILabel *phoneNumTextField;//联系方式
@property (weak, nonatomic) IBOutlet UILabel *caseTypeTextField;//案件类型
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;//案件描述


@property (nonatomic, retain) NSString *caseId; // 案件ID

@end
