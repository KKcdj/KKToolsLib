//
//  MyNetWorkManagement.m
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
    

#import "MyNetWorkManagement.h"
#import <ZBNetworking/ZBNetworking.h>
#import "NSString+AES.h"
#import "NSJSONSerialization+JSON.h"



@implementation MyNetWorkManagement
static MyNetWorkManagement *_network;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _network = [[MyNetWorkManagement alloc] init];
        [ZBRequestManager setupBaseConfig:^(ZBConfig * _Nullable config) {
            /**
             config.baseServer 设置基础服务器地址
             如果同一个环境，有多个服务器地址，可以在每个请求单独设置 requestr.server  优先级大于config.baseServer
             */
            // filtrationCacheKey因为时间戳是变动参数，缓存key需要过滤掉 变动参数,如果 不使用缓存功能 或者 没有变动参数 则不需要设置。
            config.filtrationCacheKey = @[@"timeString"];
            //全局设置 请求格式
            config.requestSerializer = ZBHTTPRequestSerializer;
            config.responseSerializer = ZBHTTPResponseSerializer;
            //更改默认请求类型，如果服务器给的接口大多不是get
            config.defaultMethodType = ZBMethodTypePOST;
            //超时时间
            config.timeoutInterval = 10;
            //请求失败 所有请求重新连接次数
            config.retryCount = 0;
            //开log
            config.consoleLog = NO;
            
            /**responseContentTypes
             内部已存在的响应数据类型
             @"text/html",@"application/json",@"text/json", @"text/plain",@"text/javascript",@"text/xml",@"image/",@"multipart/form-data",@"application/octet-stream",@"application/zip"
             */
            config.responseContentTypes=@[@"text/aaa",@"text/bbb"];//添加新的响应数据类型
            config.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
        }];
    });
    return _network;
}



#pragma mark - 网络求情
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
                    failure:(void (^)(NSError *error))failure{
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest *request){
        //入参加密、通用入参等逻辑放着里
        if ([requestDomain isEqualToString:API_BACKEND_HTTPS]) {
            if ([apiAddress isEqualToString:@"Aldvpn/smtinit"]) {//初始化接口特殊处理
                NSArray *tmpArr = [[NSString stringWithString:[body objectForKey:@"version"]] componentsSeparatedByString:@"."];
                NSString *thisvdata = @"5A1B0C0D";
                if(tmpArr.count == 3){
                    thisvdata = [NSString stringWithFormat:@"5A%@B%@C%@D",tmpArr.firstObject,tmpArr[1],tmpArr.lastObject];
                }

                NSString *hisftvalue = @"x";
                if([[body objectForKey:@"isfirst"] isEqualToString:@"0"]){
                    hisftvalue = @"y";
                }
                NSMutableDictionary *bodyC = [[NSMutableDictionary alloc] initWithDictionary:body];
                [bodyC setObject:[[body objectForKey:@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""] forKey:@"version"];

                request.parameters = @{@"vmsg":[NSString AES128_Encrypt:[KKTools arrayAndDicChangeJsonString:bodyC]],
//                                       @"thisvdata":thisvdata,
//                                       @"hisftvalue":hisftvalue,
                };
            } else {
                NSMutableDictionary *bodyC = [[NSMutableDictionary alloc] initWithDictionary:body];
                [bodyC setObject:[[body objectForKey:@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""] forKey:@"version"];
                request.parameters = @{@"vmsg":[NSString AES128_Encrypt:[KKTools arrayAndDicChangeJsonString:bodyC]]};
            }
        } else {
            request.parameters = body;
        }
        
        
        
        switch (method) {
            case MyNetWorkMethodGet:
            {
                request.methodType = ZBMethodTypeGET;
            }
                break;
            case MyNetWorkMethodPost:
            {
                request.methodType = ZBMethodTypePOST;
            }
                break;
            case MyNetWorkMethodJson:
            {
                request.methodType = ZBMethodTypePOST;
                request.requestSerializer = ZBJSONRequestSerializer;
            }
                break;
            case MyNetWorkMethodFile:
            {
                
            }
                break;
            case MyNetWorkMethodImages:
            {
                
            }
                break;

            default:
                break;
        }
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.url = [NSString stringWithFormat:@"%@%@",requestDomain,apiAddress];
        request.headers = [[NSMutableDictionary alloc] initWithDictionary:headers];
    }  success:^(id responseObj,ZBURLRequest * request){
        if ([responseObj isKindOfClass:[NSData class]]) {
            NSString *encodedReceipt = [[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding];
            
            if ([requestDomain isEqualToString:API_BACKEND_HTTPS]) {
                responseObj = [NSJSONSerialization objectWithJSONData:[NSString AES128_Decrypt:encodedReceipt type:0]];
                success(responseObj);
                KKLog(@"请求地址:%@%@\n请求入参%@\n请求成功回参%@",requestDomain,apiAddress, [NSString stringWithFormat:@"%@",body],[NSString stringWithFormat:@"%@",responseObj]);
            }else if ([requestDomain isEqualToString:API_CONFIG_HTTPS]){
                responseObj = [NSJSONSerialization objectWithJSONData:[NSString AES128_Decrypt:encodedReceipt type:1]];
                success(responseObj);
                KKLog(@"请求地址:%@%@\n请求入参%@\n请求成功回参%@",requestDomain,apiAddress, [NSString stringWithFormat:@"%@",body],[NSString stringWithFormat:@"%@",responseObj]);
            }else{
                success([encodedReceipt jsonValueDecoded]);
                KKLog(@"请求地址:%@%@\n请求入参%@\n请求成功回参%@",requestDomain,apiAddress, [NSString stringWithFormat:@"%@",body],[encodedReceipt jsonValueDecoded]);
            }
        }else{
            KKLog(@"请求地址:%@%@\n请求入参%@\n请求失败回参:\n格式不对",requestDomain,apiAddress,[NSString stringWithFormat:@"%@",body]);
        }
    } failure:^(NSError *error){
        failure(error);
        KKLog(@"请求地址:%@%@\n请求入参%@\n请求失败回参:\n格式不对",requestDomain,apiAddress,[NSString stringWithFormat:@"%@",body]);
    }];
}




#pragma mark - 批量下载文件
/// 批量下载文件
/// - Parameters:
///   - lineArray: 地址数组
///   - progress: 进度
///   - success: 完成
///   - failure: 失败
///   - finished: 成功
- (void)BatchDownloadFile:(NSArray *)lineArray  progress:(void (^)(NSProgress * _Nullable progress))progress success:(void (^)(id  json))success failure:(void (^)(id errStr))failure finished:(void (^)(id  json))finished{
    [ZBRequestManager requestBatchWithConfig:^(ZBBatchRequest * _Nonnull batchRequest) {
        [lineArray enumerateObjectsUsingBlock:^(NSMutableDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZBURLRequest *request = [ZBURLRequest new];
            if ([obj isKindOfClass:[NSString class]]) {
                request.url = (NSString *)obj;
            } else {
                request.url = [obj objectForKey:@"url"];
            }
            
            request.parameters = obj;
            request.methodType = ZBMethodTypeDownLoad;
            [batchRequest.requestArray addObject:request];
        }];
    } progress:progress success:^(id  _Nullable responseObject, ZBURLRequest * _Nullable request) {
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        failure(error);
    } finished:^(NSArray * _Nullable responseObjects, NSArray<NSError *> * _Nullable errors, NSArray<ZBURLRequest *> * _Nullable requests) {
    }];
}




@end
