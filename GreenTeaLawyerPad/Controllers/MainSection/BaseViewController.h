//
//  BaseViewController.h
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)setLeftBtn;

-(void)setBackBtn;

-(void)setBackBtnEventHandler:(void (^)(id sender))handler;

-(void)setLeftBtnImage:(UIImage *)btnImage eventHandler:(void (^)(id sender))handler;

-(void)setRightBtn:(NSString *)btnTitle eventHandler:(void (^)(id sender))handler;

-(void)setRightBtnImage:(UIImage *)btnImage eventHandler:(void (^)(id sender))handler;
@end
