//
//  AlertViewManager.m
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
    

#import "AlertViewManager.h"


//全局信号量
dispatch_semaphore_t _globalInstancesLockSEM;
//执行QUEUE的Name
char *QUEUE_NAME_SEM = "com.alert.queueSEM";

//初始化 -- 借鉴YYWebImage的写法
static void _AlertViewInitGlobalSEM() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _globalInstancesLockSEM = dispatch_semaphore_create(1);
    });
}
@interface AlertViewManager ()

@end




@implementation AlertViewManager
- (void)showWithExecuteBlock:(ExecuteBlock)executeBlock {
    dispatch_async(dispatch_queue_create(QUEUE_NAME_SEM, DISPATCH_QUEUE_SERIAL), ^{
        dispatch_semaphore_wait(_globalInstancesLockSEM, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (executeBlock) {
                WKAppManager.currentController.tabBarController.tabBar.userInteractionEnabled = NO;
                executeBlock();
            }
        });
    });
}

- (void)dismissWithExecuteBlock:(ExecuteBlock)executeBlock {
    dispatch_async(dispatch_queue_create(QUEUE_NAME_SEM, DISPATCH_QUEUE_SERIAL), ^{
        dispatch_semaphore_signal(_globalInstancesLockSEM);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (executeBlock) {
                WKAppManager.currentController.tabBarController.tabBar.userInteractionEnabled = YES;
                executeBlock();
            }
        });
    });
}


+ (instancetype)shareManager {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static id instan = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instan = [super allocWithZone:zone];
    });
    return instan;
}

- (instancetype)init {
    if (self = [super init]) {
        _AlertViewInitGlobalSEM();
    }
    return self;
}
@end
