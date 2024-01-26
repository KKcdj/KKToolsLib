//
//  KKViewController.h
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

@interface KKViewController : UIViewController
/// 主布局视图
@property (nonatomic) MyLinearLayout *rootLayoutView;

@property (nonatomic) MyRelativeLayout *layoutView;
@end

NS_ASSUME_NONNULL_END
