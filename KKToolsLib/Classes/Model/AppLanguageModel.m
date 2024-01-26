//
//  AppLanguageModel.m
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
    

#import "AppLanguageModel.h"

@implementation AppLanguageModel
+ (NSString *)primaryKey{
    return @"primaryKey";
}


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"primaryKey"  :  @"ID",
             };
}


+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static AppLanguageModel *appLanguageModel = nil;
    dispatch_once(&onceToken, ^{
        appLanguageModel = [[AppLanguageModel alloc] init];
    });
    return appLanguageModel;
}
@end
