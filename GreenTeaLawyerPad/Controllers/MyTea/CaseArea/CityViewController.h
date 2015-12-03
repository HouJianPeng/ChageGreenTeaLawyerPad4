//
//  CityViewController.h
//  greenTeaUser
//
//  Created by mac on 15/7/15.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityViewControllerDelegate <NSObject>
-(void)getThecity:(NSMutableArray*)array withProviceId:(NSString*)proviceId  CityId:(NSString*)cityId withAreaID:(NSString*)areaID;
@end
@interface CityViewController : UIViewController
@property(nonatomic,assign)id <CityViewControllerDelegate> delegate;
@property(nonatomic,retain)NSString*cityId;
@end
