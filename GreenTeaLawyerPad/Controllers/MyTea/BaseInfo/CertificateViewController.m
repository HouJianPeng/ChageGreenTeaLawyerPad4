//
//  CertificateViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/16.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "CertificateViewController.h"
#import "CameraTakeMamanger.h"
#import "UploadManager.h"
#import "CertTableViewCell.h"

@interface CertificateViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *theCertTableView;
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, assign) BOOL isAudited;

@end


@implementation CertificateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相关证件";
    self.array = @[@"身份证正面", @"身份证反面", @"手持身份证照片", @"执政照"];
    self.theCertTableView.delegate = self;
    self.theCertTableView.dataSource = self;
    _theCertTableView.tableFooterView = [[UIView alloc]init];
    [self networkForIsAudited];
}

- (void)networkForIsAudited
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_ACCOUNT_GET&userId=%@", SERVER_HOST_PRODUCT, userId];
    
    [NetWork POST:url parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSDictionary *infoDic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_ACCOUNT_GET"] objectForKey:@"list"] firstObject] firstObject];
        NSLog(@"infoDic = %@", infoDic);
        Account *account = [Account initAccount:infoDic];
        
        if ([account.isAudited isEqualToString:@"2"]) {
            self.isAudited = YES;
        } else {
            self.isAudited = NO;
        }
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellindetifier = @"CertTableViewCell";
    CertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellindetifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellindetifier owner:nil options:nil] firstObject];
    }
    NSLog(@"%@", self.idCardArray);
    cell.theNameLabel.text = self.array[indexPath.row];
    [cell.theCertImage setImage:[UIImage imageNamed:[self.idCardArray objectAtIndex:indexPath.row]]];
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", SERVER_IMAGE, [self.idCardArray objectAtIndex:indexPath.row]];
    [cell.theCertImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isAudited == YES) {
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"您已经通过审核，不能修改证件" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        }];
    } else {
        [[CameraTakeMamanger sharedInstance] cameraSheetInController:self.certDelegate handler:^(UIImage *image, NSString *imagePath) {
            [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath RelPathEnum:RelPathLawyer success:^(NSString *assetId, NSString *fileName, NSString *fileUrl) {
                // 上传成功逻辑
                NSLog(@"assetId = %@", assetId);
                [self.idCardArray replaceObjectAtIndex:indexPath.row withObject:fileUrl];
                [self.theCertTableView reloadData];
                
                if (indexPath.row == 0) {
                    [self netWorkForUpLoadCardsWithAssetId:fileUrl cardType:@"idCardPicUrl"];
                    NSLog(@"url = %@", fileUrl);
                }
                if (indexPath.row == 1) {
                    [self netWorkForUpLoadCardsWithAssetId:fileUrl cardType:@"idCardReversePicUrl"];
                }
                if (indexPath.row == 2) {
                    [self netWorkForUpLoadCardsWithAssetId:fileUrl cardType:@"idCardHandPicUrl"];
                }
                if (indexPath.row == 3) {
                    [self netWorkForUpLoadCardsWithAssetId:fileUrl cardType:@"certificatePicUrl"];
                }
            } failure:^(NSString *message) {
                // 上传失败逻辑
                NSLog(@"message = %@", message);
            }];
            
        }];
    }
    
}


- (void)netWorkForUpLoadCardsWithAssetId:(NSString *)assetId cardType:(NSString *)cardType
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
    NSString *extensions = [NSString stringWithFormat:@"%@<paramValue>%@<paramSplit>",cardType, assetId];
    
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_INFO_UPDATE&userId=%@&extensions=%@",SERVER_HOST_PRODUCT, userId, extensions];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetWork POST:urlStr parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSDictionary *accountDic = [[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_INFO_UPDATE"] objectForKey:@"object"];
        
        NSNumber *success = (NSNumber *)[accountDic objectForKey:@"success"];
        NSLog(@"success = %@", success);
        
        if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSLog(@"上传成功");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"证件上传成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            NSLog(@"上传失败");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"证件上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }];
}



- (void)theSecond {
    NSLog(@"上传身份证正面");
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        //                [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *fileUrl, NSString *serverUrl, NSString *message) {
        //                    // 更新本地图片
        //                    [AccountManager sharedInstance].account.headImage = fileUrl;
        //                    [[AccountManager sharedInstance] saveAccountInfoToDisk];
        //                    [self.tableView reloadData];
        //
        //                    // 调用图片更新
        //                    [APIClient execute:self.apiRequestAlterUserImage];
        //
        //                } failure:^(NSString *message) {
        //                    DDLogInfo(@"message:%@",message);
        //                }];
    }];
}

- (void)thefirst{
    NSLog(@"上传身份证反面");
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        //                [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *fileUrl, NSString *serverUrl, NSString *message) {
        //                    // 更新本地图片
        //                    [AccountManager sharedInstance].account.headImage = fileUrl;
        //                    [[AccountManager sharedInstance] saveAccountInfoToDisk];
        //                    [self.tableView reloadData];
        //
        //                    // 调用图片更新
        //                    [APIClient execute:self.apiRequestAlterUserImage];
        //
        //                } failure:^(NSString *message) {
        //                    DDLogInfo(@"message:%@",message);
        //                }];
    }];
    
    
}

- (void)theThird{
    NSLog(@"上传执业照");
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        //                [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *fileUrl, NSString *serverUrl, NSString *message) {
        //                    // 更新本地图片
        //                    [AccountManager sharedInstance].account.headImage = fileUrl;
        //                    [[AccountManager sharedInstance] saveAccountInfoToDisk];
        //                    [self.tableView reloadData];
        //
        //                    // 调用图片更新
        //                    [APIClient execute:self.apiRequestAlterUserImage];
        //
        //                } failure:^(NSString *message) {
        //                    DDLogInfo(@"message:%@",message);
        //                }];
    }];
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
