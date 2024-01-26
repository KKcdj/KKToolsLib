//
//  ConfigInitModel.h
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

@interface ConfigInitModel : RLMObject
/// 主健
@property (nonatomic,copy) NSString *primaryKey;
@end

NS_ASSUME_NONNULL_END
