//
//  BaseViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarStyle:(UIBarStyleBlack)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]}];

    
    UINavigationBar *appearance = [UINavigationBar appearance];
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:20];
    [appearance setTitleTextAttributes:textAttrs];
    
}

-(void)setLeftBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [backBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}


-(void)setBackBtn {

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.backBarButtonItem = backItem;
}

-(void)setBackBtnEventHandler:(void (^)(id sender))handler {
    UIImage *image = [UIImage imageNamed:@"navigationbarBack"];
    UIImage *image_h = [UIImage imageNamed:@"navigationbarBack_h"];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    NSString* backTitle = @"返回";
    CGSize titleSize = [backTitle sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0]}];

    btn.frame = CGRectMake(0, 0, image.size.width + ceilf(titleSize.width) + 10, MAX(image.size.height,ceilf(titleSize.height)));
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image_h forState:UIControlStateHighlighted];
    [btn setImage:image_h forState:UIControlStateSelected];
    
    [btn setTitle:backTitle forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0., -15., 0., 0.);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0., -25., 0., 0.);
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:19];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)setLeftBtnImage:(UIImage *)btnImage eventHandler:(void (^)(id sender))handler {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)setRightBtn:(NSString *)btnTitle eventHandler:(void (^)(id sender))handler
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)setRightBtnImage:(UIImage *)btnImage eventHandler:(void (^)(id sender))handler {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
