//
//  CaseModel.h
//  greenTeaUser
//
//  Created by Herron on 15/7/10.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CoreData/CoreData.h>


@interface CaseModel : NSObject

@property (nonatomic, retain) NSString * caseId;            // 案件ID
@property (nonatomic, retain) NSString * createTime;        // 创建时间
@property (nonatomic, retain) NSString * caseNo;            // 案件编号
@property (nonatomic, retain) NSString * caseName;          // 案件名称
@property (nonatomic, retain) NSString * caseTitle;         // 案件标题
@property (nonatomic, retain) NSString * districtId;        // 描述
@property (nonatomic, retain) NSString * street;            // 街道
@property (nonatomic, retain) NSString * userId;            // 用户ID
@property (nonatomic, retain) NSString * businessType;      // 案件类型编号
@property (nonatomic, retain) NSString * name;              // 用户姓名
@property (nonatomic, retain) NSString * mobile;            // 手机号
@property (nonatomic, retain) NSString * lawyerNum;         // 律师编号
@property (nonatomic, retain) NSString * statusLabel;       // 案件状态
@property (nonatomic, retain) NSString * businessTypeLabel; // 案件类型
@property (nonatomic, retain) NSString * descriptionStr;    // 案件描述
@property (nonatomic, retain) NSString * cycleTime;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * reply;
@property (nonatomic, retain) NSString * disPlayName;
@end
