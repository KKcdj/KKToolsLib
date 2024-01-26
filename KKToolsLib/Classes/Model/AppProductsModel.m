//
//  AppProductsModel.m
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
    

#import "AppProductsModel.h"

@implementation AppProductsModel
+ (NSString *)primaryKey{
    return @"product_num";
}


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"product_id"  :  @"id",
        @"product_num"  :  @"num",
        @"product_type"  :  @"type",
             };
}


+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static AppProductsModel *appProductsModel = nil;
    dispatch_once(&onceToken, ^{
        appProductsModel = [[AppProductsModel alloc] init];
    });
    return appProductsModel;
}
@end
