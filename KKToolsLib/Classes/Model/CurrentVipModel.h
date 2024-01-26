//
//  CurrentVipModel.h
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

@interface CurrentVipModel : RLMObject
/// 主键
@property  NSString *primaryKey;

/// 到期时间戳
@property NSDate *expire_time;
 
/// 永久会员
@property  BOOL is_forever;

/// 商品id
@property NSString *product_id;


+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
