//
//  HttpUtils.m
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
    
//NSString *qq = [dict7 valueForKeyPath:@"school.class.student.name"]; 重大发现

#import "HttpUtils.h"
#import "MyNetWorkManagement.h"




@implementation HttpUtils
#pragma mark - 广告支付接口
+(void)requestAppAdsList:(NSDictionary *)headers
                    body:(NSDictionary *)body
                 success:(void (^)(id  data))success
                 failure:(void (^)(NSError *error))failure{
    [[MyNetWorkManagement shareInstance] NetRequestWithDomain:API_CONFIG_HTTPS apiAddress:@"Api/data" headers:headers body:body requestMethod:MyNetWorkMethodGet whetherResponseCache:NO success:^(id  _Nonnull json) {
        if([[json objectForKey:@"status"] isEqual:@1]){
            success([json objectForKey:@"data"]);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
/// apple stroe 获取应该版本号
+(void)requestAppStoreAppVersion:(NSDictionary *)headers
                            body:(NSDictionary *)body
                         success:(void (^)(id  data))success
                         failure:(void (^)(NSError *error))failure{
    [[MyNetWorkManagement shareInstance] NetRequestWithDomain:@"http://itunes.apple.com" apiAddress:@"lookup" headers:headers body:body requestMethod:MyNetWorkMethodGet whetherResponseCache:NO success:^(id  _Nonnull json) {
        if ([json objectForKey:@"results"] && [[json objectForKey:@"results"] objectForKey:@"version"]) {
            success([[json objectForKey:@"results"] objectForKey:@"version"]);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark - 苹果支付接口
/// 获取退款历史记录接口所需token
+(void)requestStoreKitRefundRecordsForToken:(NSDictionary *)headers
                                       body:(NSDictionary *)body
                                    success:(void (^)(id  data))success
                                    failure:(void (^)(NSError *error))failure{
    [[MyNetWorkManagement shareInstance] NetRequestWithDomain:API_CONFIG_HTTPS apiAddress:@"Api/getjwttoken" headers:headers body:body requestMethod:MyNetWorkMethodGet whetherResponseCache:NO success:^(id  _Nonnull json) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}




#pragma mark - kmdata接口
/// 分页获取新歌
+(void)requestNewsonglist:(NSMutableDictionary *)headers
                           body:(NSMutableDictionary *)body
                        success:(void (^)(id  data))success
                        failure:(void (^)(id errStr))failure{
    [body setObject:[KKTools returnLanguageCode] forKey:@"lang"];
    [body setObject:[KKTools returnHttpQuestAppVersion] forKey:@"version"];
    [body setObject:KKAppID forKey:@"appstoreid"];
    [body setObject:@"1" forKey:@"media_type"];
    
    [[MyNetWorkManagement shareInstance] NetRequestWithDomain:API_BACKEND_HTTPS apiAddress:@"Krost/newsonglist" headers:headers body:body requestMethod:MyNetWorkMethodGet whetherResponseCache:NO success:^(id  _Nonnull json) {
        if([[json objectForKey:@"status"] isEqual:@1]){
            NSArray *arr = [json objectForKey:@"data"];
            NSMutableArray *marr = [NSMutableArray new];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MusicModel *model = [MusicModel modelWithJSON:obj];
                [marr addObject:model];
            }];
            success(marr);
        }else{
//            failure([json objectForKey:@"msg"]);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
