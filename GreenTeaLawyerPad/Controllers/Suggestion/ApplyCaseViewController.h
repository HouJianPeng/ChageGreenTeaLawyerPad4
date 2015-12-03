//
//  ApplyCaseViewController.h
//  greenTeaLawyer
//
//  Created by Herron on 15/7/12.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyCaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *caseDescriptionTextView;//案例回复
@property (weak, nonatomic) IBOutlet UITextField *commissionTextField; // 佣金
@property (weak, nonatomic) IBOutlet UITextField *executionTimeTextField; // 执行时间
//@property (weak, nonatomic) IBOutlet UITextField *successCaseTextField;//
@property (weak, nonatomic) IBOutlet UITextField *attachmentTextField;//上传
@property (nonatomic, copy) NSString *caseId;

@end
