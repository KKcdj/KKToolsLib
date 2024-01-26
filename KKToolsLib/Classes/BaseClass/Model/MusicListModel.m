//
//  MusicListModel.m
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
    

#import "MusicListModel.h"






@implementation MusicListModel

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static MusicListModel *musicListModel = nil;
    dispatch_once(&onceToken, ^{
        musicListModel = [[MusicListModel alloc] init];
    });
    return musicListModel;
}


// 主键
+ (NSString *)primaryKey {
    return @"primaryKey";
}

+ (NSArray<NSString *> *)requiredProperties{
    return @[@"listName"];
}
@end
