//
//  CaseManager.m
//  greenTeaUser
//
//  Created by Herron on 15/7/10.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "CaseManager.h"
#import "ValueUtils.h"

@implementation CaseManager

+ (CaseModel *)caseModelWithDict:(NSDictionary *)dict
{
    NSString *caseId = [ValueUtils stringFromObject:[dict objectForKey:@"id"]];

    /*
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"userId = '%@' AND caseId = '%@'", [AccountManager sharedInstance].account.userId, caseId]];
    
    CaseModel *caseModel = [CaseModel MR_findFirstWithPredicate:predicate];
    
    if (caseModel == nil) {
        caseModel = [CaseModel MR_createEntity];
    }
    */
    CaseModel *caseModel = [[CaseModel alloc] init];
    caseModel.caseId = caseId;
    caseModel.descriptionStr = [ValueUtils stringFromObject:[dict objectForKey:@"description"]];
    caseModel.caseNo = [ValueUtils stringFromObject:[dict objectForKey:@"caseNo"]];
    caseModel.caseTitle = [ValueUtils stringFromObject:[dict objectForKey:@"caseTitle"]];
    caseModel.createTime = [ValueUtils stringFromObject:[dict objectForKey:@"createTime"]];
    caseModel.caseName = [ValueUtils stringFromObject:[dict objectForKey:@"caseName"]];
    caseModel.districtId = [ValueUtils stringFromObject:[dict objectForKey:@"districtId"]];
    caseModel.street = [ValueUtils stringFromObject:[dict objectForKey:@"street"]];
    caseModel.userId = [ValueUtils stringFromObject:[dict objectForKey:@"userId"]];
    caseModel.businessType = [ValueUtils stringFromObject:[dict objectForKey:@"businessType"]];
    caseModel.name = [ValueUtils stringFromObject:[dict objectForKey:@"name"]];
    caseModel.mobile = [ValueUtils stringFromObject:[dict objectForKey:@"mobile"]];
    caseModel.lawyerNum = [ValueUtils stringFromObject:[dict objectForKey:@"lawyerNum"]];
    caseModel.statusLabel = [ValueUtils stringFromObject:[dict objectForKey:@"statusLabel"]];
    caseModel.businessTypeLabel = [ValueUtils stringFromObject:[dict objectForKey:@"businessTypeLabel"]];
    caseModel.disPlayName = [ValueUtils stringFromObject:[dict objectForKey:@"displayName"]];
    return caseModel;
}


@end
