//
//  Toast.m
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
    

#import "Toast.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation Toast

// MARK: - 公开方法
/// 显示菊花
+ (void)showIndeterminate:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeIndeterminate isLoading:YES];
    hud.margin = 10;
}

/// 显示文字提示，2s后自动隐藏
+ (void)showMessage:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:message mode:MBProgressHUDModeText isLoading:NO];
    hud.offset = CGPointMake(0, view.bounds.size.height * 0.4);
    [hud hideAnimated:YES afterDelay:2];
}

/// 显示文字提示，2s后自动隐藏
/// @param message  文字
+ (void)showMessage:(NSString *)message {
    UIView  *view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [self createHUD:view message:message mode:MBProgressHUDModeText isLoading:NO];
    hud.offset = CGPointMake(0, view.bounds.size.height * 0.4);
    [hud hideAnimated:YES afterDelay:2];
}
/// 显示图片
/// @param view     添加到view上
+ (void)showIcon:(NSString *)icon view:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [UIImage imageNamed:icon];
    UIImageView *customView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    customView.image = image;
    hud.customView = customView;
    [hud hideAnimated:YES afterDelay:1];
}

/// 隐藏
+ (void)hide:(UIView *)view {
    for (UIView *hud in view.subviews) {
        if ([hud isKindOfClass:MBProgressHUD.class]) {
            [(MBProgressHUD *)hud hideAnimated:YES];
            [hud removeFromSuperview];
        }
    }
}

// MARK: - 私有方法
/// 创建 HUD
+ (MBProgressHUD *)createHUD:(UIView *)view message:(NSString *)message mode:(MBProgressHUDMode)mode isLoading:(BOOL)isLoading {
    if (!view) { return nil; }
    if (mode != MBProgressHUDModeAnnularDeterminate) {
        [self hide:view];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    BOOL isBlack = mode == MBProgressHUDModeIndeterminate || mode == MBProgressHUDModeText || mode == MBProgressHUDModeAnnularDeterminate || (mode == MBProgressHUDModeCustomView && message && message.length > 0);
    hud.bezelView.backgroundColor = isBlack ? [UIColor.blackColor colorWithAlphaComponent:0.5] : UIColor.clearColor;
    hud.contentColor = UIColor.whiteColor;
    hud.margin = 10;
    hud.userInteractionEnabled = isLoading;
    hud.removeFromSuperViewOnHide = true;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.mode = mode;
    return hud;
}

+ (MBProgressHUD *)createHUDs:(UIView *)view message:(NSString *)message mode:(MBProgressHUDMode)mode isLoading:(BOOL)isLoading {
    if (!view) { return nil; }
    if (mode != MBProgressHUDModeAnnularDeterminate) {
        [self hide:view];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    BOOL isBlack = mode == MBProgressHUDModeIndeterminate || mode == MBProgressHUDModeText || mode == MBProgressHUDModeAnnularDeterminate || (mode == MBProgressHUDModeCustomView && message && message.length > 0);
    hud.bezelView.backgroundColor = isBlack ? [UIColor.blackColor colorWithAlphaComponent:0.5] : UIColor.clearColor;
    hud.contentColor = UIColor.whiteColor;
    hud.margin = 10;
    hud.userInteractionEnabled = isLoading;
    hud.removeFromSuperViewOnHide = true;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.mode = mode;
    return hud;
}

@end
