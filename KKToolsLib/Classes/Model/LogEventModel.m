//
//  LogEventModel.m
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
    

#import "LogEventModel.h"

@implementation LogEventModel
+ (NSString *)primaryKey{
    return @"primaryKey";
}


+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static LogEventModel *logEventModel = nil;
    dispatch_once(&onceToken, ^{
        logEventModel = [[LogEventModel alloc] init];
    });
    return logEventModel;
}
@end
