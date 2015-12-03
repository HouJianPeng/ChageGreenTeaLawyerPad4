//
//  NewsModel.h
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/23.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, strong) NSString *newsTitle;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *newsId;
@end
