//
//  UploadApi.h
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "APIRequest.h"

typedef enum : NSUInteger {
    RelPathPerson,
    RelPathEnterprise,
    RelPathLawyer,
    RelPathApply,
    RelPathResponse,
} RelPathEnum;

@interface UploadApi : APIRequest

//- (void)setApiParamsWithFilePath:(NSString *)filePath;

- (void)setApiParamsWithFilePath:(NSString *)filePath RelPath:(RelPathEnum)pathEnum;


@end
