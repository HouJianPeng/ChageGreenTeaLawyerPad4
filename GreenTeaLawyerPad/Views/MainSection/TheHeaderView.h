//
//  TheHeaderView.h
//  GreenTeaUserPad
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imagePlayerView.h"


@interface TheHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *theapplyViewButton;


@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;


@property(nonatomic,strong)NSMutableArray * array;
@end
