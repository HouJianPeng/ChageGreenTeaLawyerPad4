//
//  ChangeEmailViewController.h
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/7/13.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BaseViewController.h"

@protocol ChangeEmailViewControllerDelegate <NSObject>

- (void)sendToBasicInfoWithMessage:(NSString *)message;

@end


@interface ChangeEmailViewController : BaseViewController

@property (nonatomic, assign) id<ChangeEmailViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString *emailStr;

@end
