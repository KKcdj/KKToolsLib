//
//  MusicModel.m
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
    

#import "MusicModel.h"
#import "MusicListModel.h"

@implementation MusicModel
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static MusicModel *musicModel = nil;
    dispatch_once(&onceToken, ^{
        musicModel = [[MusicModel alloc] init];
    });
    return musicModel;
}


// 主键
+ (NSString *)primaryKey {
    return @"primaryKey";
}

// 设置反向关系
+ (NSDictionary<NSString *,RLMPropertyDescriptor *> *)linkingObjectsProperties{
    return @{
        @"musicList":[RLMPropertyDescriptor descriptorWithClass:MusicListModel.class propertyName:@"musicMarr"],
    };
}



+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"primaryKey"  :  @"id",
             };
}
@end
