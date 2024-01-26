//
//  HttpUtils.h
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
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpUtils : NSObject
#pragma mark - 广告支付接口
+(void)requestAppAdsList:(NSDictionary *)headers
                    body:(NSDictionary *)body
                 success:(void (^)(id  data))success
                 failure:(void (^)(NSError *error))failure;

/// apple stroe 获取应该版本号
+(void)requestAppStoreAppVersion:(NSDictionary *)headers
                            body:(NSDictionary *)body
                         success:(void (^)(id  data))success
                         failure:(void (^)(NSError *error))failure;


#pragma mark - 苹果支付接口
/// 获取退款历史记录接口所需token
+(void)requestStoreKitRefundRecordsForToken:(NSDictionary *)headers
                                       body:(NSDictionary *)body
                                    success:(void (^)(id  data))success
                                    failure:(void (^)(NSError *error))failure;




#pragma mark - kmdata接口
/// 分页获取新歌
+(void)requestNewsonglist:(NSMutableDictionary *)headers
                     body:(NSMutableDictionary *)body
                  success:(void (^)(id  data))success
                  failure:(void (^)(id errStr))failure;
@end

NS_ASSUME_NONNULL_END
