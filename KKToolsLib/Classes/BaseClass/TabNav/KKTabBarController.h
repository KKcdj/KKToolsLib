//
//  KKTabBarController.h
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

@interface KKTabBarController : UITabBarController
/// 横幅广告视图
@property (nonatomic,strong) MyRelativeLayout *bannerAdView;

/// 加载banner广告资源
- (void)initBannerAD;
@end

NS_ASSUME_NONNULL_END
