//
//  WKAppManager.h
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

@interface WKAppManager : NSObject
+ (instancetype)sharedInstance;

+ (__kindof UINavigationController *)currentNavigationController;

+ (__kindof UIViewController *)currentController;
@end

NS_ASSUME_NONNULL_END
