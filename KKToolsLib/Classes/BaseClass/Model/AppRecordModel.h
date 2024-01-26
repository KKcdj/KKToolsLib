//
//  AppRecordModel.h
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
    

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger , AppVersionStatus) {
    AppVersionStatusFirst = 0,// 首次安装
    AppVersionStatusUpdata,//更新
    AppVersionStatusNo,//版本不变
};

@interface AppRecordModel : RLMObject
+ (instancetype)shareInstance;

/// ID
@property  NSString *primaryKey;

/// app版本状态
@property  AppVersionStatus appVersionStatus;

/// app版本号
@property  NSString *appVersion;


@property  NSString *myname;


@end

NS_ASSUME_NONNULL_END
