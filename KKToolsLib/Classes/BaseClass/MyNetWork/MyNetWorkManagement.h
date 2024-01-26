//
//  MyNetWorkManagement.h
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

typedef NS_ENUM(NSInteger , MyNetWorkMethod) {
    MyNetWorkMethodGet = 0,
    MyNetWorkMethodPost,
    MyNetWorkMethodJson,
    MyNetWorkMethodFile,
    MyNetWorkMethodImages,
};


@interface MyNetWorkManagement : NSObject
+(instancetype)shareInstance;



/// 网络求情
/// - Parameters:
///   - requestDomain: 请求域名
///   - apiAddress: 请求地址
///   - headers: 请求头
///   - body: 请求体
///   - method: 请求类型
///   - isSesponseCache: 是否缓存
///   - success: 成功回调
///   - failure: 失败回调
-(void)NetRequestWithDomain:(NSString *)requestDomain
              apiAddress:(NSString *)apiAddress
                 headers:(NSDictionary *)headers
                    body:(NSDictionary *)body
           requestMethod:(MyNetWorkMethod)method
    whetherResponseCache:(BOOL)isSesponseCache
                 success:(void (^)(id  json))success
                 failure:(void (^)(NSError *error))failure;



/// 批量下载文件
/// - Parameters:
///   - lineArray: 地址数组
///   - progress: 进度
///   - success: 完成
///   - failure: 失败
///   - finished: 成功
- (void)BatchDownloadFile:(NSArray *)lineArray progress:(void (^)(NSProgress * _Nullable progress))progress success:(void (^)(id  json))success failure:(void (^)(id errStr))failure finished:(void (^)(id errStr))finished;
@end

NS_ASSUME_NONNULL_END
