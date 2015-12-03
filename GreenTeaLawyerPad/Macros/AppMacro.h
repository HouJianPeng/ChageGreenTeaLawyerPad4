//
//  AppMacro.h
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//
#import "NetWorkMacro.h"
#import "ColorMacro.h"
#import "NetWorkMacro.h"
#import "NotificationMacro.h"
#import "NetWork.h"

#ifndef greenTeaUser_AppMacro_h
#define greenTeaUser_AppMacro_h

#define SystemOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define kScreenBoundWidth [UIScreen mainScreen].bounds.size.width

#define kScreenBoundHeight [UIScreen mainScreen].bounds.size.height

#define IS_IPHONE4      kScreenBoundHeight == 480
#define IS_IPHONE5      kScreenBoundHeight == 568
#define IS_IPHONE6      kScreenBoundHeight == 667
#define IS_IPHONE6P     kScreenBoundHeight == 736

#define kNavigationHeight 64

#define kTabbarHeight 49

#define KeyWindow [UIApplication sharedApplication].keyWindow

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

#endif
