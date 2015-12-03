//
//  MainViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/20.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//
#import "MainViewController.h"
#import "MainCollectionViewCell.h"
#import "TheFirstCollectionViewCell.h"
#import "TheHeaderView.h"
#import "SecondHeaderCollectionReusableView.h"
#import "InFormationViewController.h"
#import "AboutUsViewController.h"
#import "CaseManagerViewController.h"
#import "LoginViewController.h"
#import "DetialViewController.h"
#import "Maininformation.h"
#import "InfoViewController.h"
#import "ApplyForCaseViewController.h"
#import "MJRefresh.h"
#import "AccountManager.h"
//#import "SuggestionViewController.h"
//#import "RecommendViewController.h"
//#import "CaseDelegateViewController.h"
//#import "ThroughTrainViewController.h"
//#import "PerfectInfoViewController.h"

static NSInteger page =1;
static NSString * cellIndetifier = @"MainCollectionViewCell";
static NSString * firstCellIndetifier = @"TheFirstCollectionViewCell";
static NSString * theHeadCellIndetifier = @"TheHeaderView";
static NSString * theSecondCellIndetifier = @"SecondHeaderCollectionReusableView";

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, ImagePlayerViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *theMainCollectionView;
@property (weak, nonatomic) IBOutlet UIView *myTeaView;
@property (weak, nonatomic) IBOutlet UILabel *theNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theAccountLable;
@property (weak, nonatomic) IBOutlet UILabel *theRedPacketLabel;
@property (weak, nonatomic) IBOutlet UIButton *theCaseManagerButton;
@property (weak, nonatomic) IBOutlet UIButton *theMyTeaAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *theComplateButton;
@property (weak, nonatomic) IBOutlet UIButton *theExitButton;

@property(nonatomic,strong) NSMutableArray *inforArray;
@property(nonatomic,assign) BOOL clikced;
@property(nonatomic,strong) NSMutableArray *imageArray;

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view insertSubview:self.theMainCollectionView aboveSubview:self.myTeaView];
    self.clikced = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTheMyTeaView];
    [self network];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self loadTheMyTeaView];
    [self creatTheImageArray];
    [self loadBlackButton];
    [self loadTheCollectionView];
}

-(void)loadTheMyTeaView{

    self.myTeaView.backgroundColor = [UIColor blackColor];
    NSString *name = [NSString stringWithFormat:@"%@",[AccountManager sharedInstance].account.displayName];
    self.theNameLabel.text =name;
    self.theNameLabel.backgroundColor = [UIColor redColor];
    self.theNameLabel.textColor = [UIColor whiteColor];
    self.theNameLabel.layer.cornerRadius = 20;
    self.theAccountLable.text = @"";
    self.theAccountLable.textColor = [UIColor whiteColor];
    self.theRedPacketLabel.text=@"";
    self.theRedPacketLabel.textColor = [UIColor whiteColor];
    [self.theCaseManagerButton addTarget:self action:@selector(clickTheMyTeaViewButton:) forControlEvents:(UIControlEventTouchUpInside)];
    self.theCaseManagerButton.tag = 200;
    [self.theMyTeaAccountButton addTarget:self action:@selector(clickTheMyTeaViewButton:) forControlEvents:(UIControlEventTouchUpInside)];
    self.theMyTeaAccountButton.tag = 201;
    [self.theComplateButton addTarget:self action:@selector(clickTheMyTeaViewButton:) forControlEvents:(UIControlEventTouchUpInside)];
    self.theComplateButton.tag = 202;
    [self.theExitButton addTarget:self action:@selector(clickTheMyTeaViewButton:) forControlEvents:(UIControlEventTouchUpInside)];
    self.theExitButton.tag =203;
}

-(void)clickTheMyTeaViewButton:(UIButton*)button{
    if (button.tag ==200) {
        CaseManagerViewController * view = [[CaseManagerViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (button.tag==201){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此服务暂未开通" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (button.tag==202){
        // 资料完善
        InfoViewController *infoVC = [[InfoViewController alloc] init];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要退出" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = 2000;
        alert.delegate = self;
        [alert show];
      
    }
}

-(void)creatTheImageArray{
    self.imageArray = [@[] mutableCopy];
    for (int i = 0; i<10; i++) {
        NSString *imageName  = [NSString stringWithFormat:@"Home_business%d",i];
        [self.imageArray addObject:imageName];
    }
}

#pragma mark 加载collectionView
-(void)loadTheCollectionView{
    self.clikced = YES;
    UINib *nib = [UINib nibWithNibName:cellIndetifier bundle:[NSBundle mainBundle]];
    [self.theMainCollectionView registerNib:nib forCellWithReuseIdentifier:cellIndetifier];
    self.theMainCollectionView.backgroundColor = [UIColor blackColor];
    UINib *tnib = [UINib nibWithNibName:firstCellIndetifier bundle:[NSBundle mainBundle]];
    [self.theMainCollectionView registerNib:tnib forCellWithReuseIdentifier:firstCellIndetifier];
    self.theMainCollectionView.delegate  = self;
    self.theMainCollectionView.minimumZoomScale = 0;
    self.theMainCollectionView .backgroundColor = [UIColor whiteColor];
     UINib *headnib = [UINib nibWithNibName:theHeadCellIndetifier bundle:nil];
    //TheHeaderView
    [self.theMainCollectionView registerNib:headnib forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:theHeadCellIndetifier];
    UINib *secondheadnib = [UINib nibWithNibName:theSecondCellIndetifier bundle:nil];
    [self.theMainCollectionView registerNib:secondheadnib forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:theSecondCellIndetifier];
}

-(void)loadBlackButton{
    UIButton *backmyTea = [UIButton buttonWithType:UIButtonTypeCustom];
    backmyTea.frame = CGRectMake(10, 0, 50, 34);
    [backmyTea setImage:[UIImage imageNamed:@"mytea"] forState:UIControlStateNormal];
    backmyTea.tag = 100;
    [backmyTea addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(0, 0, 40, 44);
    login.tag = 101;
    [login setImage:[UIImage imageNamed:@"prev_01"] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
//    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
//    search.frame = CGRectMake(0, 0, 230, 44);
//    search.tag = 102;
//    [search setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    [search addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:search];
    UIBarButtonItem *myTeaBarButton = [[UIBarButtonItem alloc] initWithCustomView:backmyTea];
    UIBarButtonItem *loginBarButton = [[UIBarButtonItem alloc] initWithCustomView:login];
    NSArray * buttonarray = @[myTeaBarButton,loginBarButton];
    self.navigationItem.leftBarButtonItems = buttonarray;
    UIButton *mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mainButton.frame = CGRectMake(20, 0, 50, 34);
    [mainButton setImage:[UIImage imageNamed:@"a_01"] forState:(UIControlStateNormal)];
    [mainButton addTarget:self action:@selector(doBack:) forControlEvents:(UIControlEventTouchUpInside)];
    mainButton.tag = 111;
//    UIButton *conslutButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    conslutButton.frame = CGRectMake(20, 0, 50, 34);
//     [conslutButton addTarget:self action:@selector(doBack:) forControlEvents:(UIControlEventTouchUpInside)];
//    [conslutButton setImage:[UIImage imageNamed:@"a_02"] forState:(UIControlStateNormal)];
//    conslutButton.tag = 112;
    UIButton *aboutusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutusButton.frame = CGRectMake(20, 0, 50, 34);
    [aboutusButton setImage:[UIImage imageNamed:@"a_03"] forState:(UIControlStateNormal)];
     [aboutusButton addTarget:self action:@selector(doBack:) forControlEvents:(UIControlEventTouchUpInside)];
    aboutusButton.tag = 113;
    UIBarButtonItem * main = [[UIBarButtonItem alloc] initWithCustomView:mainButton];
//    UIBarButtonItem * conslut = [[UIBarButtonItem alloc] initWithCustomView:conslutButton];
    UIBarButtonItem * aboutus = [[UIBarButtonItem alloc] initWithCustomView:aboutusButton];
    NSArray * rightArray = @[aboutus,main];
    self.navigationItem.rightBarButtonItems = rightArray;
    
}

- (void)doBack:(UIButton *)sender
{
    if (sender.tag ==112) {
//        ConslutionViewController*view = [[ConslutionViewController alloc] init];
//        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender.tag ==113){
        AboutUsViewController*about =[[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }
    else if (sender.tag ==100){
        if ([AccountManager sharedInstance].account.isLogin) {
            
        }
        else{
        LoginViewController * login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        }
    }
    else if (sender.tag ==101){
        if ([AccountManager sharedInstance].account.isLogin)
        {
            
        [self thenetWork];
        if (self.clikced) {
        [self.view insertSubview:self.myTeaView aboveSubview:self.theMainCollectionView];
            self.clikced =!self.clikced;
                          }
        else{
            [self.view insertSubview:self.theMainCollectionView aboveSubview:self.myTeaView];
            self.clikced =!self.clikced;
            }
        }
        else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请您先登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.delegate = self;
            alert.tag = 1000;
            [alert show];
        }
    }
    else{
    }
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
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        MainCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndetifier forIndexPath:indexPath];
        cell.theFirstImageView.backgroundColor = [UIColor blueColor];
        Maininformation * info = self.inforArray[indexPath.row];
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",SERVER_IMAGE,info.picUrl];
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
    else{
        TheFirstCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:firstCellIndetifier forIndexPath:indexPath];
        cell.backgroundColor =[UIColor blackColor];
        NSString * sectionImage = [NSString stringWithFormat:@"main_b0%ld",(long)indexPath.row];
        cell.theFirstImage.image = [UIImage imageNamed:sectionImage];
         return cell;
    }
   
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }
    else{
        if (self.inforArray.count>4) {
            return 4;
        }
        else{
            return self.inforArray.count;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/2,0);
    }
    else
    {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/3.2);
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TheHeaderView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:theHeadCellIndetifier forIndexPath:indexPath];
        headView.imagePlayerView.imagePlayerViewDelegate = self;
        headView.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
        [headView.imagePlayerView reloadData];
        [headView.theapplyViewButton addTarget:self action:@selector(pushTheCaseManagerController) forControlEvents:(UIControlEventTouchUpInside)];
        return headView;
    }
    else{
        SecondHeaderCollectionReusableView * secondHeaderView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:theSecondCellIndetifier forIndexPath:indexPath];
        secondHeaderView.theSecondImage.image = [UIImage imageNamed:@"headmyTea"];
        [secondHeaderView.theMoreButton addTarget:self action:@selector(moreDetial) forControlEvents:(UIControlEventTouchUpInside)];
        return secondHeaderView;
    }
}

-(void)pushTheCaseManagerController{
    ApplyForCaseViewController * apply = [[ApplyForCaseViewController alloc] init];
    [self.navigationController pushViewController:apply animated:YES];
}

- (void)network
{
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ADV_ADVERTISEMENT_LIST_BLOCK&positionName=1436840296083&pageLimit=10&page=%ld",SERVER_HOST_PRODUCT, page];
    [NetWork GET:url parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSArray *arrayTem = [[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ADV_ADVERTISEMENT_LIST_BLOCK"] objectForKey:@"list"] firstObject];
        self.inforArray = [@[] mutableCopy];
        for (NSDictionary *dic in arrayTem) {
            Maininformation * info = [[Maininformation alloc] init];
            info.content = dic[@"content"];
            info.creatTime =dic[@"createTime"];
            info.title = dic[@"label"];
            info.newsId = dic[@"id"];
            info.picUrl = dic[@"picUrl"];
            [self.inforArray addObject:info];
        }
      
  [self.theMainCollectionView reloadSections:[[NSIndexSet alloc] initWithIndex:1]];
    }];
}

#pragma mark 更多详情页面
-(void)moreDetial{
    NSLog(@"更多");
    InFormationViewController * info = [[InFormationViewController alloc] init];
    [self.navigationController pushViewController:info animated:YES];
}

#pragma mark alertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1000) {
        if(buttonIndex==0){
            LoginViewController * login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
        }
    }
    else if (alertView.tag ==2000){
        if (buttonIndex==0) {
            Account *account = [[Account alloc] init];
            [AccountManager sharedInstance].account = account;
            [[AccountManager sharedInstance] saveAccountInfoToDisk];
            [self.view insertSubview:self.theMainCollectionView aboveSubview:self.myTeaView];
            self.clikced = YES;
            self.view.backgroundColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
            [self loadTheMyTeaView];
        }
    }
    
}

#pragma mark 区头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 400);
    }
    else{
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    }
}

#pragma mark 点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetialViewController * detial = [[DetialViewController alloc] init];
    Maininformation *info = [self.inforArray objectAtIndex:indexPath.row];
    detial.advertisementId = info.newsId;
    [self.navigationController pushViewController:detial animated:YES];
}

#pragma mark - ImagePlayerViewDelegate
/**
 *  Number of items
 *
 *  @return Number of items
 */
- (NSInteger)numberOfItems {
    return 2;
}

/**
 *  Init imageview
 *
 *  @param imagePlayerView ImagePlayerView object
 *  @param imageView       UIImageView object
 *  @param index           index of imageview
 */
#pragma mark 轮播图
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index {
    NSString * image = [NSString stringWithFormat:@"banner_0%d",index+1];
    imageView.image =[UIImage imageNamed:image];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
        return 0;
 
}

#pragma  审核判断
- (void)thenetWork{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_ACCOUNT_GET&userId=%@", SERVER_HOST_PRODUCT, userId];
    [NetWork POST:url parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *infoDic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_ACCOUNT_GET"] objectForKey:@"list"] firstObject] firstObject];
        NSLog(@"infoDic = %@", infoDic);
        if ([infoDic[@"isAudited"]isEqualToString:@"1"]) {
            [AccountManager sharedInstance].isAudit = NO;
        }
        else{
            [AccountManager sharedInstance].isAudit = YES;
        }
    }];
}

@end
