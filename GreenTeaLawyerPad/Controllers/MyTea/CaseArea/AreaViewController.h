//
//  AreaViewController.h
//  greenTeaUser
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AreaTheAreaViewControllerDelegate <NSObject>
-(void)getThearea:(NSMutableArray*)array withcityID:(NSString*)cityId withArea:(NSString*)areaID;
@end
@interface AreaViewController : UIViewController
@property(nonatomic,retain)NSString*areaString;
@property(nonatomic,assign)id <AreaTheAreaViewControllerDelegate> delegate;
@end
