//
//  NetWork.m
//  DouBanMovie
//
//  Created by Herron on 15/7/4.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"
@implementation NetWork

+ (void)GET:(NSString *)url parmater:(NSDictionary *)dic Block:(void (^)(NSData *data))block
{
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当前网络未知
        if (status == -1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前网络未知" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        // 当前无连接
        if (status == 0) {
            // 提示
//            [TSMessage showNotificationWithTitle:NSLocalizedString(@"网络未连接", nil) subtitle:NSLocalizedString(@"请检查您的网络连接", nil)type:TSMessageNotificationTypeError];
            // 加载轮消失
//            [SVProgressHUD dismiss];
        }
        // 当前为3G网络
        if (status == 1) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            // 对https加密解析
            manager.securityPolicy.allowInvalidCertificates = YES;
            [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
            /**
             * code = 3840
             */
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            // 加载风火轮
//            [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
            [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                // 获取的数据传回去
                block(responseObject);
//                [SVProgressHUD dismiss];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error = %@", error);
                // 解析错误时提示网络连接不稳
//                [TSMessage showNotificationWithTitle:NSLocalizedString(@"您的网络连接不稳定", nil) subtitle:NSLocalizedString(nil, nil)type:TSMessageNotificationTypeError];
            }];
        }
        // 当前为WiFi
        if (status == 2) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            /**
             *    对https加密解析
             */
            manager.securityPolicy.allowInvalidCertificates = YES;
            /**
             *   解决code = 3840
             */
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
            /**
             *   加载烽火轮消失
             */
//            [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
            /**
             *   请求数据正确
             */
            [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                // 数据回调
                block(responseObject);
//                [SVProgressHUD dismiss];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                [SVProgressHUD dismiss];
                // 解析错误时提示网络连接不稳
//                [TSMessage showNotificationWithTitle:NSLocalizedString(@"您的网络连接不稳定", nil) subtitle:NSLocalizedString(nil, nil)type:TSMessageNotificationTypeError];
                NSLog(@"error = %@", error);
            }];
        }
    }];
}

+ (void)POST:(NSString *)url parmater:(NSDictionary *)dic Block:(void (^)(NSData *data))block
{
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当前网络未知
        if (status == -1) {
            static int flag = 1;
            if (flag == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前网络未知" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
            flag++;
        }
        // 当前无连接
        if (status == 0) {
            static int flag = 1;
            if (flag == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络未连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            };
        }
        // 当前为3G网络
        if (status == 1) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            // 对https加密解析
            manager.securityPolicy.allowInvalidCertificates = YES;
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
            [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                // 获取的数据传回去
                block(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error = %@", error);
            }];
        }
        // 当前为WiFi
        if (status == 2) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            // 对https加密解析
            manager.securityPolicy.allowInvalidCertificates = YES;
            [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
            [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                block(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error = %@", error);
            }];
        }
    }];
}


@end


