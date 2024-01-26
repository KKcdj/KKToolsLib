//
//  AppRoutes.h
//  Application
//  
//  Created by 陈德军 on 2024/1/24.
//  Copyright ©合肥维方科技有限公司. All rights reserved.
//  
//                      ____   ____      __
//                     / ___\ / _  \    / /
//                    / /    / / / /   / /
//                   / /___ / /_/ /?__/ /
//                  /_ -_-_/____,‘\____/
//
//
    

#import <JLRoutes/JLRoutes.h>

NS_ASSUME_NONNULL_BEGIN



@interface AppRoutes : JLRoutes

/// 注册路由
+ (void)registerRoutes;

/// 路由一个URL，调用handler阻塞匹配URL的模式，直到返回YES。
/// - Parameter urlString: 路由字符串
+ (BOOL)routeWithUrlString:(NSString *)urlString;

///// 路由一个URL 带参
///// - Parameters:
/////   - urlString: 路由字符串
/////   - params: 传参
//+ (BOOL)routeWithUrlString:(NSString *)urlString params:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
