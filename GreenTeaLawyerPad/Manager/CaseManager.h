//
//  CaseManager.h
//  greenTeaUser
//
//  Created by Herron on 15/7/10.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaseModel.h"

@interface CaseManager : NSObject

+ (CaseModel *)caseModelWithDict:(NSDictionary *)dict;

@end
