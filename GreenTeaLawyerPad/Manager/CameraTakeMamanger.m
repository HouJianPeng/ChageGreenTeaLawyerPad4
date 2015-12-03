//
//  CameraTakeMamanger.m
//  yilingdoctorCRM
//
//  Created by 张玺 on 14/10/31.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import "CameraTakeMamanger.h"
#import "UIImage+Camera.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraTakeMamanger()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong) UIViewController *vc;
@property(nonatomic, strong) UIImagePickerController *imagePickerController;
@property(nonatomic, strong) void (^resultBlock)(UIImage *image ,NSString * imagePath);
@property(nonatomic, strong) void (^resultVideoBlock)(NSURL *videoUrl);
@end

@implementation CameraTakeMamanger

static CameraTakeMamanger *sharedInstance = nil;
#pragma mark Singleton Model
+ (CameraTakeMamanger *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CameraTakeMamanger alloc]init];
        sharedInstance.imagePickerController = [[UIImagePickerController alloc]init];
        sharedInstance.imagePickerController.delegate = sharedInstance;
        sharedInstance.imagePickerController.allowsEditing = YES;
    });
    return sharedInstance;
}

- (void)cameraSheetInController:(UIViewController *)vc handler:(void (^)(UIImage *image ,NSString * imagePath))block {
    self.vc = vc;
    self.resultBlock = block;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    
    [sheet bk_setHandler:^{
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            DDLogInfo(@"拍照");
            // 跳转到相机
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            [self.vc presentViewController:self.imagePickerController animated:YES completion:^{}];
        }];
    } forButtonAtIndex:0];
    [sheet bk_setHandler:^{
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            DDLogInfo(@"相册页面");
            // 跳转到相册页面
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            [self.vc presentViewController:self.imagePickerController animated:YES completion:^{}];
        }];
    } forButtonAtIndex:1];
    [sheet showInView:vc.view];
}

- (void)imageWithCameraInController:(UIViewController *)vc handler:(void (^)(UIImage *image ,NSString * imagePath))block {
    self.vc = vc;
    self.resultBlock = block;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self.vc presentViewController:self.imagePickerController animated:YES completion:^{}];
}

- (void)imageWithPhotoInController:(UIViewController *)vc handler:(void (^)(UIImage *image ,NSString * imagePath))block {
    self.vc = vc;
    self.resultBlock = block;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self.vc presentViewController:self.imagePickerController animated:YES completion:^{}];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (![mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // 摄像
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        self.resultVideoBlock(videoUrl);
        
    } else {
        // 照片
        [picker dismissViewControllerAnimated:YES completion:^{}];
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSString *imageName = [NSString stringWithFormat:@"%@.png",[NSUUID UUID].UUIDString];
        
        [self saveImage:image withName:imageName];
        
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        self.resultBlock(savedImage,fullPath);
    }
    
};
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.vc dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *temp = UIImageJPEGRepresentation(currentImage, 1);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    CGFloat tempSize = [temp length] / 1024;
    
    // 规定大小
    CGFloat theSize = 200.0;
    // 大于200kb 就压缩
    CGFloat ratio;
    
    if (tempSize > theSize) {
        ratio = (theSize / tempSize) * 2.5;
    } else {
        ratio = 1;
    }
    temp = UIImageJPEGRepresentation([currentImage fixOrientation:currentImage], ratio);
    
    // 将图片写入文件
    [temp writeToFile:fullPath atomically:YES];
    
}

@end