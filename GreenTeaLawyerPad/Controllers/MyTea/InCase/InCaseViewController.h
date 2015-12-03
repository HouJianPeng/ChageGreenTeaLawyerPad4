//
//  InCaseViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface InCaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *caseNumLabel;//案件编号
@property (weak, nonatomic) IBOutlet UILabel *caseTypeLabel;//案例类型
@property (weak, nonatomic) IBOutlet UILabel *caseStateLabel;//案例状态
@property (weak, nonatomic) IBOutlet UITextView *caseDetailTextView;//案件管理详情
@property (weak, nonatomic) IBOutlet UITextView *myReplyTextView;  // 我的回复
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel; // 期望薪资
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;  // 执行时间
@property (nonatomic, retain) NSString *caseId;
@property (nonatomic, copy) NSString *caseTitle; // 案件标题
@property (nonatomic, copy) NSString *caseNumber; // 案件编号
@property (nonatomic, copy) NSString *caseType; // 案件类型
@property (nonatomic, copy) NSString *caseDetail; // 案件详情
@property (nonatomic, copy) NSString *caseState; // 案件状态
@end
