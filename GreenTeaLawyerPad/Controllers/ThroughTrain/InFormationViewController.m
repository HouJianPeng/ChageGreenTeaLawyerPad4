//
//  InFormationViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "InFormationViewController.h"
#import "MainCollectionViewCell.h"
#import "Maininformation.h"
#import "DetialViewController.h"
#import "MJRefresh.h"
static NSInteger page =1;
static NSString * cellIndentifier =@"MainCollectionViewCell";
@interface InFormationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *informationCollectionView;
@property(nonatomic,strong)NSMutableArray * infoArray;
@property(nonatomic,strong)NSString * newsId;
@end
@implementation InFormationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"绿茶网头条";
    [self loadTheCollectionView];
    [self network];
    [self loadBlackButton];
    
    __block  InFormationViewController *weakSelf = self;
    self.informationCollectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.infoArray.count==10) {
            page++;
        }
        [self.informationCollectionView.footer beginRefreshing];
        [weakSelf network];
        [self.informationCollectionView.footer endRefreshing];
        
    }];
    self.informationCollectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         page = 1;
    [self.informationCollectionView.header beginRefreshing];
        [weakSelf network];
        [self.informationCollectionView.header endRefreshing];
    }];
}
-(void)loadBlackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)network
{
    self.infoArray = [@[] mutableCopy];
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ADV_ADVERTISEMENT_LIST_BLOCK&positionName=1436840296083&pageLimit=10&page=%ld",SERVER_HOST_PRODUCT, page];
    [NetWork GET:url parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSArray *arrayTem = [[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ADV_ADVERTISEMENT_LIST_BLOCK"] objectForKey:@"list"] firstObject];
        
        for (NSDictionary *dic in arrayTem) {
            Maininformation * info = [[Maininformation alloc] init];
            info.content = dic[@"content"];
            info.creatTime =dic[@"createTime"];
            info.title = dic[@"label"];
            info.newsId = dic[@"id"];
            info.picUrl = dic[@"picUrl"];
            [self.infoArray addObject:info];
            //CaseModel *caseModel = [CaseManager caseModelWithDict:dic];
        }
        [self.informationCollectionView reloadData];
    }];
}

-(void)loadTheCollectionView{
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    self.title =@"更多资讯";
    UINib * nib = [UINib nibWithNibName:cellIndentifier bundle:[NSBundle mainBundle]];
    [self.informationCollectionView registerNib:nib forCellWithReuseIdentifier:cellIndentifier];
    self.informationCollectionView.delegate = self;
    self.informationCollectionView.backgroundColor= [UIColor whiteColor];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.infoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
//     NSString *imageName = [NSString stringWithFormat:@"fb_0%ld.jpg",indexPath.row+1];
     Maininformation * info = self.infoArray[indexPath.row];
//    cell.theFirstImageView.image = [UIImage imageNamed:imageName];
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", SERVER_IMAGE, info.picUrl];
    [cell.theFirstImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"firstImagePad"]];
    cell.theNameLabel.text = info.title;
    cell.theNameLabel.backgroundColor = [UIColor whiteColor];
    cell.theTimeLabel.textColor = [UIColor redColor];
    cell.theTimeLabel.text = info.creatTime;
    cell.theDescriptionLabel.backgroundColor = [UIColor whiteColor];
    NSString *filterHtmlTagStr = [self filterHtmlTag:info.content]; // added by necaluo
    NSString *subStr = [NSString stringWithFormat:@"%@%@", [filterHtmlTagStr substringToIndex:40], @"..."];
    cell.theDescriptionLabel.text = subStr;
    
    return cell;
}
- (NSString *)filterHtmlTag:(NSString *)originHtmlStr{
    NSString *result = nil;
    NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
    if (arrowTagStartRange.location != NSNotFound) { //如果找到
        NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
        //        NSLog(@"start-> %d   end-> %d", arrowTagStartRange.location, arrowTagEndRange.location);
        //        NSString *arrowSubString = [originHtmlStr substringWithRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location)];
        result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];
        // NSLog(@"Result--->%@", result);
        return [self filterHtmlTag:result];    //递归，过滤下一个标签
    }else{
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];  // 过滤&nbsp等标签
        //result = [originHtmlStr stringByReplacingOccurrencesOf  ........
    }
    return result;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        return CGSizeMake([UIScreen mainScreen].bounds.size.width/2-10, [UIScreen mainScreen].bounds.size.height/3.3);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetialViewController * detial = [[DetialViewController alloc] init];
    InFormationViewController *info = [self.infoArray objectAtIndex:indexPath.row];
    detial.advertisementId = info.newsId;
    [self.navigationController pushViewController:detial animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
