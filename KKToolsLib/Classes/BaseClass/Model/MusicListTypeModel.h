//
//  MusicListTypeModel.h
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
    

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MusicListTypeModel : RLMObject
+(instancetype)shareInstance;


/// 主键
@property NSString *primaryKey;

/// 类型名字
@property NSString *typeName;

/// 歌单数组
@property RLMArray<MusicListModel *><MusicListModel> *musicListMarr;
@end

NS_ASSUME_NONNULL_END
