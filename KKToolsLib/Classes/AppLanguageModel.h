//
//  AppLanguageModel.h
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
//测试提交
    

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppLanguageModel : RLMObject
/// ID
@property  NSString *primaryKey;

/// 语言标题
@property  NSString *language_text;

/// 语言代码
@property  NSString *language_key;

/// 1=使用     0=未使用
@property  BOOL is_select;


+ (instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
