//
//  UploadApi.m
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "UploadApi.h"

@implementation UploadApi

- (ApiAccessType)accessType
{
    return kApiAccessUpload;
}

- (NSString *)urlAction {
    return kUploadFileAction;
}

//- (void)setApiParamsWithFilePath:(NSString *)filePath {
//    self.filePath = filePath;
//}

- (void)setApiParamsWithFilePath:(NSString *)filePath RelPath:(RelPathEnum)pathEnum {
    self.filePath = filePath;
    switch (pathEnum) {
        case RelPathPerson:
            [self.params setObject:@"/docs/person" forKey:@"relPath"];
            break;
        case RelPathApply:
            [self.params setObject:@"/docs/apply" forKey:@"relPath"];
            break;
        case RelPathEnterprise:
            [self.params setObject:@"/docs/enterprise" forKey:@"relPath"];
            break;
        case RelPathLawyer:
            [self.params setObject:@"/docs/lawyer" forKey:@"relPath"];
            break;
        case RelPathResponse:
            [self.params setObject:@"/docs/response" forKey:@"relPath"];
            break;
            
        default:
            break;
    }
    
}


@end
