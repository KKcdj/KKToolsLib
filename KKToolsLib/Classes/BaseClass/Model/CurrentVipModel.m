//
//  CurrentVipModel.m
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
    

#import "CurrentVipModel.h"

@implementation CurrentVipModel
+ (NSString *)primaryKey{
    return @"primaryKey";
}

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static CurrentVipModel *currentVipModel = nil;
    dispatch_once(&onceToken, ^{
        currentVipModel = [[CurrentVipModel alloc] init];
    });
    return currentVipModel;
}
@end
