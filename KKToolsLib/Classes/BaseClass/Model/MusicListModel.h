//
//  MusicListModel.h
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




#import "RLMObject.h"
#import "MusicModel.h"

NS_ASSUME_NONNULL_BEGIN
RLM_COLLECTION_TYPE(MusicListModel)



@interface MusicListModel : RLMObject

+(instancetype)shareInstance;


/// 主键
@property NSString *primaryKey;

/// 歌单名字
@property NSString *listName;

/// 歌曲数组
@property RLMArray<MusicModel *><MusicModel> *musicMarr;
@end

NS_ASSUME_NONNULL_END
