//
//  NewsVM.h
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/23.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"

@interface NewsVM : NSObject

+ (NewsModel *)newsModelWithDict:(NSDictionary *)newsDict;
@end
