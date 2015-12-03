//
//  ChangeAreaController.h
//  GreenTeaLawyerPad
//
//  Created by 侯建鹏 on 15/11/18.
//  Copyright © 2015年 BeiJingYuntai. All rights reserved.
//

#import "BaseViewController.h"

//修改地址
@protocol ChangeAreaViewControllerDelegate <NSObject>

- (void)sendToInfoWithMessage:(NSString *)message;

@end

@interface ChangeAreaController : BaseViewController

@property (nonatomic, assign) id<ChangeAreaViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *businessType; // 地域信息

@property (nonatomic, copy) NSString *areaStr;

@end
