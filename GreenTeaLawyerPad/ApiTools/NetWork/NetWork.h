//
//  NetWork.h
//  DouBanMovie
//
//  Created by Herron on 15/7/4.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWork : NSObject

+ (void)GET:(NSString *)url parmater:(NSDictionary *)dic Block:(void (^)(NSData *data))block; // get 请求方式

+ (void)POST:(NSString *)url parmater:(NSDictionary *)dic Block:(void (^)(NSData *data))block; // post 请求方式

@end
