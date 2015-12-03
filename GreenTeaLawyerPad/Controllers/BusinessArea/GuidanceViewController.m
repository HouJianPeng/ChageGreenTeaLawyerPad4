//
//  GuidanceViewController.m
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "GuidanceViewController.h"
#import "GuidanceCollectionViewCell.h"
#import "MainViewController.h"

@interface GuidanceViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@end

@implementation GuidanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layoutPageSubviews];
    
    [self.collectionView registerNib:[GuidanceCollectionViewCell nibWithGuidanceCell] forCellWithReuseIdentifier:kGuidanceCollectionViewCell];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)layoutPageSubviews {
    self.flowLayout.itemSize = CGSizeMake(kScreenBoundWidth, kScreenBoundHeight);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    
//    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = YES;
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GuidanceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGuidanceCollectionViewCell forIndexPath:indexPath];
    NSString *imgStr = [NSString stringWithFormat:@"Guidance%@.jpg", @(indexPath.row)];
        cell.tf_backGroundView.backgroundColor = [UIColor redColor];
    cell.tf_backGroundView.image = [UIImage imageNamed:imgStr];
    
    if (indexPath.row == 4) {
//        cell.tf_enterButton.hidden = NO;
//        [cell.tf_enterButton addTarget:self action:@selector(enterClick:) forControlEvents:UIControlEventTouchUpInside];
//        
    } else {
        cell.tf_enterButton.hidden = YES;
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==4) {
        
        [AccountManager changeRootVCWithMMDrawer];
//         MainViewController * mainView =[[MainViewController alloc] init];
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:mainView];
//        self.window.rootViewController = nav;

    }
    
}
#pragma mark - event response
- (void)enterClick:(UIButton *)button {
    [AccountManager changeRootVCWithMMDrawer];
}
@end
