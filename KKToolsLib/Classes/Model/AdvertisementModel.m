//
//  AdvertisementModel.m
//  FileMusic
//  
//  Created by 陈德军 on 2024/1/23.
//  Copyright ©合肥维方科技有限公司. All rights reserved.
//  
//                      ____   ____      __
//                     / ___\ / _  \    / /
//                    / /    / / / /   / /
//                   / /___ / /_/ /?__/ /
//                  /_ -_-_/____,‘\____/
//
//
    

#import "AdvertisementModel.h"

@implementation AdvertisementModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID"  :  @"id"
             };
}

+ (NSString *)primaryKey{
    return @"ID";
}


+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static AdvertisementModel *advertisementModel = nil;
    dispatch_once(&onceToken, ^{
        advertisementModel = [[AdvertisementModel alloc] init];
    });
    return advertisementModel;
}
@end
