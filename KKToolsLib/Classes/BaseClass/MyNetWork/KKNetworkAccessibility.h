//
//  KKNetworkAccessibility.h
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

extern NSString * const KKNetworkAccessibilityChangedNotification;

typedef NS_ENUM(NSUInteger, KKNetworkAccessibleState) {
    KKNetworkChecking  = 0,
    KKNetworkUnknown     ,
    KKNetworkAccessible  ,
    KKNetworkRestricted  ,
};

typedef void (^NetworkAccessibleStateNotifier)(KKNetworkAccessibleState state);

@interface KKNetworkAccessibility : NSObject
/**
 开启 KKNetworkAccessibility
 */
+ (void)start;

/**
 停止 KKNetworkAccessibility
 */
+ (void)stop;

/**
 当判断网络状态为 KKNetworkRestricted 时，提示用户开启网络权限
 */
+ (void)setAlertEnable:(BOOL)setAlertEnable;

/**
  通过 block 方式监控网络权限变化。
 */
+ (void)setStateDidUpdateNotifier:(void (^)(KKNetworkAccessibleState))block;

/**
 返回的是最近一次的网络状态检查结果，若距离上一次检测结果短时间内网络授权状态发生变化，该值可能会不准确。
 */
+ (KKNetworkAccessibleState)currentState;
@end

NS_ASSUME_NONNULL_END
