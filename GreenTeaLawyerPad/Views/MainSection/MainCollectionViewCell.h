//
//  MainCollectionViewCell.h
//  GreenTeaUserPad
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *theFirstImageView;
@property (weak, nonatomic) IBOutlet UILabel *theNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *theDescriptionLabel;

@end
