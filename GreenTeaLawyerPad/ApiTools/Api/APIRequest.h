//
//  APIRequest.h
//  yilingdoctorCRM
//
//  Created by zhangxi on 14/10/27.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkMacro.h"
//#import "APIResult.h"
#import "AccountManager.h"
@class APIRequest;
@protocol APIRequestDelegate <NSObject>
@optional
- (void)serverApi_RequestFailed:(APIRequest *)api error:(NSError *)error;
- (void)serverApi_FinishedSuccessed:(APIRequest *)api result:(NSDictionary *)sr;
//- (void)serverApi_FinishedFailed:(APIRequest *)api result:(APIResult *)sr;

//下载的代理
- (void)serverApi_DownloadSuccessed:(NSString *)filePath;
- (void)serverApi_DownloadFailed:(NSError *)error;

@end

@interface APIRequest : NSObject

@property (nonatomic, readonly) int serverType;
@property (nonatomic, readonly) NSString *serverKeyWord;
@property (nonatomic, readonly) ApiAccessType accessType;
@property (nonatomic, readonly) ApiCookieType cookieType;
@property (nonatomic, readonly) ApiResultFormat resultFormat;
@property (nonatomic, readonly) NSTimeInterval timeout;
@property (nonatomic, readonly) NSString *fullUrl;
@property (nonatomic, readonly) NSString *urlAction;

@property (nonatomic, weak) id<APIRequestDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *requestType;

@property (nonatomic, strong) NSString* apiVersion;

- (id)initWithDelegate:(id<APIRequestDelegate>)delegate;

- (void)callBackFinishedWithDictionary:(NSDictionary *)dic;
- (void)callBackFailed:(NSError *)error;

//下载的回调
- (void)downloadSuccessedCallBack:(NSString *)filePath;
- (void)downloadFailedCallBack:(NSError *)error;

- (void)appendBaseParams;
- (NSDictionary *)dictionaryWithJsonData:(NSData *)data;

@end
