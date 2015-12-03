//
//  UploadManager.h
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadApi.h"

@interface UploadManager : NSObject

+ (UploadManager *)sharedInstance;

//- (void)uploadFileWithFilePath:(NSString *)filePath
//                       success:(void (^)(NSString *assetId, NSString * fileName, NSString * fileUrl))success
//                       failure:(void (^)(NSString * message))failure;
- (void)uploadFileWithFilePath:(NSString *)filePath
                   RelPathEnum:(RelPathEnum)pathEnum
                       success:(void (^)(NSString *assetId, NSString * fileName, NSString * fileUrl))success
                       failure:(void (^)(NSString * message))failure;


@end
