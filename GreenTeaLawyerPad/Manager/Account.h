//
//  Account.h
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, copy) NSString *userId;       // 用户id
@property (nonatomic, copy) NSString *displayName;  // 用户名
@property (nonatomic, copy) NSString *userType;     // 用户类型
@property (nonatomic, copy) NSString *userName;          // 用户名（手机号）
@property (nonatomic, copy) NSString *gender;            // 性别
@property (nonatomic, copy) NSString *email;             // 邮箱
@property (nonatomic, copy) NSString *mobile;            // 手机号
@property (nonatomic, copy) NSString *birthday;          // 生日
@property (nonatomic, copy) NSString *address;           //地址------
@property (nonatomic, copy) NSString *userTypeLabel;     // 用户类型
@property (nonatomic, copy) NSString *companyName;       // 公司名
@property (nonatomic, copy) NSString *certificatePicUrl; // 证件url
@property (nonatomic, copy) NSString *certificateNumber; // 证件编号
@property (nonatomic, copy) NSString *certificateDate;   // 发证日期
@property (nonatomic, copy) NSString *certificateType;   // 证件类型
@property (nonatomic, copy) NSString *idCardPicUrl;      // 身份证url
@property (nonatomic, copy) NSString *idCardReversePicUrl;// 身份证反面url
@property (nonatomic, copy) NSString *idCard;            // 身份证号
@property (nonatomic, copy) NSString *issuingAuthority;  // 签发机关/发证机关
@property (nonatomic, copy) NSString *businessArea;      // 业务领域
@property (nonatomic, copy) NSString *institution;       // 执业机构
@property (nonatomic, copy) NSString *legalRepresentative;// 法人代表
@property (nonatomic, copy) NSString *registrationNumber;// 注册号
@property (nonatomic, copy) NSString *registeredAssets;//注册资本
@property (nonatomic, copy) NSString *residence;// 住所
@property (nonatomic, copy) NSString *idCardHandPicUrl; //手持身份证照片
@property (nonatomic, copy) NSString *isAudited;// 是否审核
@property (nonatomic, copy) NSString *cityID;
@property (nonatomic, copy) NSString *provinceID;
@property (nonatomic, copy) NSString *areaID;
@property (nonatomic, strong) NSString *isLogin;    // 是否登录




+ (Account *)initAccount:(NSDictionary *)dic;

@end
