//
//  AppRoutes.m
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
    
NSString *const AppRoutesScheme = @"FileMusic";

#import "AppRoutes.h"

@implementation AppRoutes
+ (instancetype)globalRoutes {
    return [self routesForScheme:AppRoutesScheme];
}

+ (void)registerRoutes {
    AppRoutes *routes = [self globalRoutes];
    
    // 歌曲推荐
    [routes addRoute:@"music" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        return [self handleMusicRouteWithParams:parameters];
    }];
}

+ (BOOL)routeWithUrlString:(NSString *)urlString {
    return [self routeURL:[NSURL URLWithString:urlString]];
}

+ (UINavigationController *)topNavigationController {
    return WKAppManager.currentNavigationController;
}



#pragma mark - 处理
+ (BOOL)handleMusicRouteWithParams:(NSDictionary *)params {
//    GKWYSongListViewController *listVC = [[GKWYSongListViewController alloc] init];
//    [[self topNavigationController] pushViewController:listVC animated:YES];
    return YES;
}

@end
