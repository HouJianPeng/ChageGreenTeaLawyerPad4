//
//  CameraTakeMamanger.h
//  yilingdoctorCRM
//
//  Created by 张玺 on 14/10/31.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraTakeMamanger : NSObject

+ (CameraTakeMamanger *)sharedInstance;

#pragma mark - 照片
/**
 *  @brief  从Sheet选择
 *
 *  @param vc    <#vc description#>
 *  @param block <#block description#>
 */
- (void)cameraSheetInController:(UIViewController *)vc handler:(void (^)(UIImage *image ,NSString * imagePath))block;

/**
 *  @brief  选择照相机拍照
 *
 *  @param vc    <#vc description#>
 *  @param block <#block description#>
 */
- (void)imageWithCameraInController:(UIViewController *)vc handler:(void (^)(UIImage *image ,NSString * imagePath))block;

/**
 *  @brief  从相册选择照片
 *
 *  @param vc    弹出的VC
 *  @param block 回调方法
 */
- (void)imageWithPhotoInController:(UIViewController *)vc handler:(void (^)(UIImage *image ,NSString * imagePath))block;

@end
