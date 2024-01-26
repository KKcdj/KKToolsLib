//
//  MusicListTypeModel.m
//  FileMusic
//  
//  Created by 陈德军 on 2024/1/25.
//  Copyright ©合肥维方科技有限公司. All rights reserved.
//  
//                      ____   ____      __
//                     / ___\ / _  \    / /
//                    / /    / / / /   / /
//                   / /___ / /_/ /?__/ /
//                  /_ -_-_/____,‘\____/
//
//
    

#import "MusicListTypeModel.h"

@implementation MusicListTypeModel
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static MusicListTypeModel *musicListTypeModel = nil;
    dispatch_once(&onceToken, ^{
        musicListTypeModel = [[MusicListTypeModel alloc] init];
    });
    return musicListTypeModel;
}


// 主键
+ (NSString *)primaryKey {
    return @"primaryKey";
}
@end
