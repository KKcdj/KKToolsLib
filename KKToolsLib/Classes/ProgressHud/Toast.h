//
//  Toast.h
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
    

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Toast : UIView
/// 显示菊花
/// @param view     添加到view上
+ (void)showIndeterminate:(UIView *)view;

/// 显示文字提示，2s后自动隐藏
/// @param message  文字
/// @param view     添加到view上
+ (void)showMessage:(NSString *)message view:(UIView *)view;

/// 显示文字提示，2s后自动隐藏
/// @param message  文字
+ (void)showMessage:(NSString *)message;

/// 显示图片
/// @param view     添加到view上
+ (void)showIcon:(NSString *)icon view:(UIView *)view;

/// 隐藏HUD
/// @param view     隐藏view上HUD
+ (void)hide:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
