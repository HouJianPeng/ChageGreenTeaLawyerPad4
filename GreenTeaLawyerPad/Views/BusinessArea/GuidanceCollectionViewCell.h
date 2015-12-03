//
//  GuidanceCollectionViewCell.h
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kGuidanceCollectionViewCell @"GuidanceCollectionViewCell"

@interface GuidanceCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tf_backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *tf_enterButton;


+ (UINib *)nibWithGuidanceCell;
@end
