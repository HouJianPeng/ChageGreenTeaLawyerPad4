//
//  TFImageCheckView.h
//  DoctorYL
//
//  Created by chenTengfei on 15/3/23.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 单个图片查看器
@interface TFImageCheckView : UIView<UIScrollViewDelegate>

+ (TFImageCheckView *)sharedInstance;


- (void)tf_showImageView:(UIImageView*)avatarImageView;

- (void)tf_showImageView:(UIImageView*)avatarImageView
                   Image:(UIImage *)imageNew;

- (void)tf_showImageView:(UIImageView*)avatarImageView
                   Image:(UIImage *)imageNew
                   Title:(NSString *)title
             DetailTitle:(NSString *)detailTitle;


// url方法未完善
//- (void)tf_showImageView:(UIImageView*)avatarImageView
//                ImageURL:(NSURL *)imageURL;
//
//- (void)tf_showImageView:(UIImageView*)avatarImageView
//                ImageURL:(NSURL *)imageURL
//                   Title:(NSString *)title
//             DetailTitle:(NSString *)detailTitle;






@end
