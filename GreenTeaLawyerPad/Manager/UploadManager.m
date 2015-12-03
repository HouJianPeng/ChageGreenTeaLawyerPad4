//
//  UploadManager.m
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "UploadManager.h"
#import "UploadApi.h"
#import "APIClient.h"

@interface UploadManager ()<APIRequestDelegate>

@property(nonatomic, strong) UploadApi *uploadApi;
@property(nonatomic, strong) void (^success)(NSString *assetId, NSString * fileName, NSString * fileUrl);
@property(nonatomic, strong) void (^failure)(NSString * message);



@end

@implementation UploadManager


static UploadManager *sharedInstance = nil;
#pragma mark Singleton Model
+ (UploadManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UploadManager alloc]init];
        sharedInstance.uploadApi = [[UploadApi alloc] initWithDelegate:sharedInstance];
    });
    return sharedInstance;
}

- (void)uploadFileWithFilePath:(NSString *)filePath
                   RelPathEnum:(RelPathEnum)pathEnum
                       success:(void (^)(NSString *assetId, NSString * fileName, NSString * fileUrl))success
                       failure:(void (^)(NSString * message))failure {
    self.success = success;
    self.failure = failure;
    [self.uploadApi setApiParamsWithFilePath:filePath RelPath:pathEnum];
    [APIClient execute:self.uploadApi];    
}

#pragma mark - APIRequestDelegate
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error {
    self.failure([error localizedDescription]);
}
- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(NSDictionary *)sr {
    if ([sr isKindOfClass:[NSNull class]] || sr == nil) {
        self.failure(kDefaultServerErrorString);
        return;
    }
    
    NSDictionary *result = sr[@"result"][@"scommerce"][@"SC_FILE_UPLOAD_SAVE"][@"object"];
    if ([[result objectForKey:@"success"] integerValue] == 1) {
        // 成功
//        NSString *imageUrl = [NSString stringWithFormat:@"%@%@", SERVER_IMAGE, result[@"url"]];
        self.success(result[@"assetId"], result[@"fileName"], result[@"url"]);
        
    } else {
        // 失败
        self.failure(kDefaultServerErrorString);
    }
}
@end
