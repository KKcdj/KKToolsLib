//
//  AppProductsModel.h
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

@interface AppProductsModel : RLMObject
/// 商品id
@property NSString *product_id;

/// 商品价格-字符串
@property NSString *product_price;

/// 商品价格-数字
@property CGFloat product_price_num;


@property NSString *product_num;

/// PAY_TYPE: 0=>订阅, 1=>一次性购买 不能重复购买, 2=>一次性购购买 能重复
@property(nonatomic,assign) NSInteger product_type;


+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
