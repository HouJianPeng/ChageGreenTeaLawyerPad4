//
//  GuidanceCollectionViewCell.m
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "GuidanceCollectionViewCell.h"

@implementation GuidanceCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (UINib *)nibWithGuidanceCell {
    UINib *nib = [UINib nibWithNibName:kGuidanceCollectionViewCell bundle:[NSBundle mainBundle]];
    return nib;
}
@end
