//
//  ProvinceViewController.h
//  greenTeaUser
//
//  Created by mac on 15/7/15.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProvinceViewControllerDelegate <NSObject>

-(void)pushTheProvince:(NSMutableArray*)array withProVinceID:(NSString*)prienceID withCityID:(NSString*)cityID andAreaId:(NSString*)areaId;;
@end
@interface ProvinceViewController : UIViewController
@property(nonatomic,retain)NSString*provice;
@property(nonatomic,assign)id <ProvinceViewControllerDelegate> delegate;
@end
