//
//  Account.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "Account.h"
#import "ValueUtils.h"

@implementation Account

+ (Account *)initAccount:(NSDictionary *)dic
{
    Account *account = [[Account alloc] init];
    account.userId = [ValueUtils stringFromObject:[dic objectForKey:@"cosmosPassportId4session"]];
    account.userType = [ValueUtils stringFromObject:[dic objectForKey:@"userType4session"]];
    account.displayName = [ValueUtils stringFromObject:[dic objectForKey:@"displayName"]];
    account.userName = [ValueUtils stringFromObject:[dic objectForKey:@"userName"]];
    account.gender = [ValueUtils stringFromObject:[dic objectForKey:@"gender"]];
    account.email = [ValueUtils stringFromObject:[dic objectForKey:@"email"]];
    account.mobile = [ValueUtils stringFromObject:[dic objectForKey:@"mobile"]];
    account.birthday = [ValueUtils stringFromObject:[dic objectForKey:@"birthday"]];
    account.address = [ValueUtils stringFromObject:[dic objectForKey:@"districtLabel"]];
    account.userTypeLabel = [ValueUtils stringFromObject:[dic objectForKey:@"userTypeLabel"]];
    account.companyName = [ValueUtils stringFromObject:[dic objectForKey:@"companyName"]];
    account.certificateNumber = [ValueUtils stringFromObject:[dic objectForKey:@"certificateNumber"]];
    account.certificatePicUrl = [ValueUtils stringFromObject:[dic objectForKey:@"certificatePicUrl"]];
    account.certificateDate = [ValueUtils stringFromObject:[dic objectForKey:@"certificateDate"]];
    account.certificateType = [ValueUtils stringFromObject:[dic objectForKey:@"certificateType"]];
    account.idCard = [ValueUtils stringFromObject:[dic objectForKey:@"idCard"]];
    account.idCardPicUrl = [ValueUtils stringFromObject:[dic objectForKey:@"idCardPicUrl"]];
    account.issuingAuthority = [ValueUtils stringFromObject:[dic objectForKey:@"issuingAuthority"]];
    account.businessArea = [ValueUtils stringFromObject:[dic objectForKey:@"businessArea"]];
    account.institution = [ValueUtils stringFromObject:[dic objectForKey:@"institution"]];
    account.idCardReversePicUrl = [ValueUtils stringFromObject:[dic objectForKey:@"idCardReversePicUrl"]];
    account.legalRepresentative = [ValueUtils stringFromObject:[dic objectForKey:@"legalRepresentative"]];
    account.registrationNumber = [ValueUtils stringFromObject:[dic objectForKey:@"registrationNumber"]];
    account.registeredAssets = [ValueUtils stringFromObject:[dic objectForKey:@"registeredAssets"]];
    account.residence = [ValueUtils stringFromObject:[dic objectForKey:@"residence"]];
    account.idCardHandPicUrl = [ValueUtils stringFromObject:[dic objectForKey:@"idCardHandPicUrl"]];
    account.idCardHandPicUrl = [ValueUtils stringFromObject:[dic objectForKey:@"idCardHandPicUrl"]];
    account.idCardReversePicUrl = [ValueUtils stringFromObject:[dic objectForKey:@"idCardReversePicUrl"]];
    account.isAudited = [ValueUtils stringFromObject:[dic objectForKey:@"isAudited"]];
    account.provinceID = [ValueUtils stringFromObject:dic[@"userProvince"]];
    account.cityID = [ValueUtils stringFromObject:dic[@"userCity"]];
    account.areaID = [ValueUtils stringFromObject:dic[@"userDistrict"]];
    

    
    return account;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    Account *copy = [[[self class] allocWithZone:zone] init];
    copy.userId = [self.userId copyWithZone:zone];
    copy.userType = [self.userType copyWithZone:zone];
    copy.displayName = [self.displayName copyWithZone:zone];
    copy.userName = [self.userName copyWithZone:zone];
    copy.gender = [self.gender copyWithZone:zone];
    copy.email = [self.email copyWithZone:zone];
    copy.mobile = [self.mobile copyWithZone:zone];
    copy.birthday = [self.birthday copyWithZone:zone];
    copy.userTypeLabel = [self.userTypeLabel copyWithZone:zone];
    copy.companyName = [self.companyName copyWithZone:zone];
    copy.certificateType = [self.certificateType copyWithZone:zone];
    copy.certificatePicUrl = [self.certificatePicUrl copyWithZone:zone];
    copy.certificateNumber = [self.certificateNumber copyWithZone:zone];
    copy.certificateDate = [self.certificateDate copyWithZone:zone];
    copy.idCardPicUrl = [self.idCardPicUrl copyWithZone:zone];
    copy.idCard = [self.idCard copyWithZone:zone];
    copy.issuingAuthority = [self.issuingAuthority copyWithZone:zone];
    copy.businessArea = [self.businessArea copyWithZone:zone];
    copy.institution = [self.institution copyWithZone:zone];
    copy.idCardReversePicUrl = [self.idCardReversePicUrl copyWithZone:zone];
    copy.isAudited = [self.isAudited copyWithZone:zone];
    
    return copy;
}



@end
