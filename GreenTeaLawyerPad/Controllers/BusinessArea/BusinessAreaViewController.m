//
//  BusinessAreaViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "BusinessAreaViewController.h"
#import "BusinessAreaCollectionViewCell.h"
static NSString * cellIndentifier = @"BusinessAreaCollectionViewCell";
@interface BusinessAreaViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *areaCollectionView;

@end

@implementation BusinessAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self loadTheAreaCollectionView];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadTheAreaCollectionView{
    UINib * nib = [UINib nibWithNibName:cellIndentifier bundle:[NSBundle mainBundle]];
    [self.areaCollectionView registerNib:nib forCellWithReuseIdentifier:cellIndentifier];
    self.areaCollectionView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BusinessAreaCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    NSString * string = [NSString stringWithFormat:@"bd_0%ld",indexPath.row+1];
    cell.areaImageView.image = [UIImage imageNamed:string];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/2-40, [UIScreen mainScreen].bounds.size.height/6);
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
