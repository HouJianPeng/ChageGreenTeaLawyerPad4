//
//  BasicInfoViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/16.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol BasicInfoViewControllerDelegate <NSObject>
- (void)intoPushToViewController:(UIViewController *)viewController;

@end


@interface BasicInfoViewController : BaseViewController

@property (nonatomic, assign) id<BasicInfoViewControllerDelegate> delegate;

@property(nonatomic, retain) NSMutableArray *infoArray;

@end
