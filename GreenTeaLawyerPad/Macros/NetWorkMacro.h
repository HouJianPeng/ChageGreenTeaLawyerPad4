//
//  NetWorkMacros.h
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#ifndef greenTeaUser_NetWorkMacro_h
#define greenTeaUser_NetWorkMacro_h

#define defaultWebAPITimeOutSeconds     10
#define defaultImageAPITimeOutSeconds   45

#define SERVER_HOST_PRODUCT      @"http://www.lawcheck.com.cn/cosmos.json?command="     // 服务器地址

#define SERVER_IMAGE             @"http://www.lawcheck.com.cn"                          // 图片服务器地址

#pragma mark - 请求地址
#define LoginAction                     @"scommerce.LC_SYS_LOGIN"      // 登录
#define VerificationMessageAction       @"config.smsSender"            // 注册短信验证码

#define kUploadFileAction               @"config.fileAsset"            // 上传请求

#define HomeInfoAction                  @"scommerce.LC_ADV_ADVERTISEMENT_LIST_BLOCK"    //首页最新资讯


#define SDKKey_Msg                  @"message"
#define SDKKey_Status               @"status"

#pragma mark - 错误提示
#define kDefaultServerErrorString               @"服务器异常，请稍后再试"
#define kDefaultNetWorkErrorString              @"网络连接异常"
#define kDefaultQuitErrorString                 @"您的账号已经在别处登录!"
#define kDefaultWebErrorString                  @"抱歉,此网页出现了问题"

#pragma mark - 请求类型定义
typedef enum ApiAddressType {
    kApiAddressTest                         =           1,      // 开发环境
    kApiAddressPre                          =           2,      // 灰度环境
    kApiAddressProduct                      =           3,      // 线上环境
}ApiAddressType;

typedef enum ApiErrorType {
    kApiErrorInvalidNetwork                 =           7000,       // 无效的网络
    kApiErrorInvalidJson                    =           7001,       // 无效的Json串
    kApiErrorNoResult                       =           7002,       // 返回了空字符串
    kApiErrorInvalidJsonDictionary          =           7003,       // 返回的Json串，不是转化成Dictionary
    kApiErrorInvalidApiResultFormat         =           7004,       // api的参数设置错误了，当前只支持xml和json格式
}ApiErrorType;

typedef enum ApiAccessType {
    kApiAccessGet,                      // Get方式
    kApiAccessPost,                     // Post方式
    kApiAccessPut,                      // put方式
    kApiAccessDelete,                   // delete方式
    kApiAccessDownload,                 // 下载
    kApiAccessUpload,                   // 上传
}ApiAccessType;

typedef enum ApiCookieType {
    kApiCookieNone,                      // 没有Cookie
    kApiCookieRequied,                   // 必须有Cookie
    kApiCookieOptional,                  // 可有可无Cookie
    kApiCookieCustom,                    // 自由Cookie
    kApiCookieSaveCustom,                // 保存自由cookie
}ApiCookieType;

typedef enum ApiResultFormat {
    kApiResultJson,                     // Json格式
    kApiResultXml,                      // Xml格式
}ApiResultFormat;

#pragma mark - 临时请求方式
#define LoginURL                     @"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.LC_SYS_LOGIN"                              // 登录

#define VerificationMessageURL       @"http://www.lawcheck.com.cn/cosmos.json?command=config.smsSender"                                    // 注册短信验证码

#define RegistURL                    @"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.CL_ACC_ACCOUNT_REGISTER_ACTION"            // 立即注册

#define CheckVerificationURL         @"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.LC_ACCOUNT_VERIFYCODE_CHECK"               // 注册验证码校验

#define ResetPasswordMessageURL      @"http://www.lawcheck.com.cn/cosmos.json?command=config.smsSender"                                    // 重置密码短信验证码

#define ResetPasswordURL             @"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.LC_RESET_PASSWORD"                         // 重置密码

#define CheckUserURL                 @"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.LC_ACC_GET_USER_INFO_BLOCK"                // 校验用户是否存在

#define CaseListURL                  @"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.LC_CASE_LAWCASE_LIST4USER_BLOCK"           // 案件列表

#define LogOffURL                    @"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.SC_SYS_LOGOUT"                             //注销登陆

#define CaseListDetailURL            @"http://www.lawcheck.com.cn/cosmos.json?cosmos.json?command=scommerce.LC_CASE_LAWCASE_GET_BLOCK"                 //案件详情

#define PublishCaseURL               @"http://www.lawcheck.com.cn/cosmos.json?cosmos.json?command=scommerce.LC_CASE_LAWCASE_SAVE_ACTION"               // 发布编辑案件
#define PickUpCaseYesOrNOURL         @"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.LC_CASE_LAWCASE_VERIFY_ACTION" //

#define LawerCaseListURL             @"http://www.lawcheck.com.cn/cosmos.json?cosmos.json?command=scommerce.LC_CASE_LAWCASE_LIST_BLOCK"                // 律师接案时查看的案件列表

#define LawerYesOrNoCaseURL @"cosmos.json?command=scommerce.LC_CASE_LAWCASE_VERIFY_ACTION"             // 校验用户是否可以接此案件

#define PerfectDataURL               @"http://www.lawcheck.com.cn/cosmos.json?command=scommerceLC_ACC_INFO_UPDATE"                         // 资料完善

#define UploadFileURL                @"http://www.lawcheck.com.cn/cosmos.json?command=config.fileAsset"                                    // 上传文件

#define DetailInfoAction                   @"scommerce.SC_ADV_ADVERTISEMENT_GET"           //资讯详情
#define ChangAdressURL           @"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.LC_ACC_INFO_UPDATE"

#endif
