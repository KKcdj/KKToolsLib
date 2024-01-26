//
//  AlertActionPopView.h
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
    

#import "RootPopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlertActionPopView : RootPopView
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message commit:(NSString *)commitStr;
/// 标题
@property (nonatomic,strong) NSString *title;
/// 副标题
@property (nonatomic,strong) NSString *message;
/// 提交按钮标题
@property (nonatomic,strong) NSString *commitStr;


/// 点击确认回调
@property (nonatomic,strong) void(^alertActionPopViewCommitBlock)(void);

@end

NS_ASSUME_NONNULL_END
