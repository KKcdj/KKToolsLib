//
//  LogEventModel.h
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

@interface LogEventModel : RLMObject
/// 事件名称
@property  NSString *event_name;
/// 事件ID
@property  NSString *ID;
/// 事件内容
@property  NSString *event_conten;
/// 事件发生次数
@property  NSInteger event_Num;
/// 事件创建时间
@property  NSDate *create_time;
/// 唯一标识符
@property  NSString *primaryKey;

+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
