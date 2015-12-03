//
//  NewsVM.m
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/23.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "NewsVM.h"
#import "ValueUtils.h"

@implementation NewsVM

+ (NewsModel *)newsModelWithDict:(NSDictionary *)newsDict {
    
    NewsModel *model = [[NewsModel alloc] init];
    model.newsTitle = [ValueUtils stringFromObject:[newsDict objectForKey:@"label"]];
    model.picUrl = [ValueUtils stringFromObject:[newsDict objectForKey:@"picUrl"]];
    model.content = [ValueUtils stringFromObject:[newsDict objectForKey:@"content"]];
    model.createTime = [ValueUtils stringFromObject:[newsDict objectForKey:@"createTime"]];
    model.newsId = [ValueUtils stringFromObject:[newsDict objectForKey:@"id"]];
    
    return model;
}
@end
