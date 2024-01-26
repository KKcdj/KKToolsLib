//
//  MusicModel.h
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

NS_ASSUME_NONNULL_BEGIN
RLM_COLLECTION_TYPE(MusicModel)

@interface MusicModel : RLMObject
+(instancetype)shareInstance;

/// 主键
@property NSString *primaryKey;

@property NSString *album;
@property NSString *publish_date;
@property NSString *author;
@property NSString *created_at;
@property NSString *url;
@property NSString *pic;
@property NSString *title;
@property NSString *lrc;
@property NSString *play_id;
@property NSString *is_my;
@property NSString *mus_school;



/// 是否已下载
@property BOOL isDownload;


@property (readonly) RLMLinkingObjects *musicList;
@end

NS_ASSUME_NONNULL_END
