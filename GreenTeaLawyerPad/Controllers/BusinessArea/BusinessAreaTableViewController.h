//
//  BusinessAreaTableViewController.h
//  greenTeaLawyer
//
//  Created by Herron on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BusinessTableViewControllerDelegate <NSObject>

- (void)sendBusinessToCaseList:(NSString *)str;

@end


@interface BusinessAreaTableViewController : UITableViewController

@property (nonatomic, assign) id<BusinessTableViewControllerDelegate> delegate;

@end
