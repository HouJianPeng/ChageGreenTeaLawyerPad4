//
//  CaseManagerTableViewCell.h
//  GreenTeaUserPad
//
//  Created by mac on 15/7/23.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseManagerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *thaCaseNumber;  //案件编号
@property (weak, nonatomic) IBOutlet UILabel *theCaseType;    //案件类型
@property (weak, nonatomic) IBOutlet UILabel *theTypeCase;    //案件状态
@property (weak, nonatomic) IBOutlet UIButton *theDetialButton; //查看更多
@property (weak, nonatomic) IBOutlet UILabel *theCaseTitle;     //案件标题

@end
