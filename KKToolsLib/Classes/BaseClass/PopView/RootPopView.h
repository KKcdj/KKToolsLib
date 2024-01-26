//
//  RootPopView.h
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
    

#import "MyLinearLayout.h"

typedef NS_ENUM(NSInteger , PopType) {
    PopTypeCenter = 0, //居中
    PopTypeBottom,     //底部上滑效果
    PopTypeTop,     //顶部下滑效果
};


NS_ASSUME_NONNULL_BEGIN

@interface RootPopView : MyLinearLayout
@property(nonatomic,strong)UIButton *btnBack;//背景

- (instancetype)initWithType:(PopType)type;
// 动画类型
@property (nonatomic,assign) PopType animationType;
// 视图显示
-(void)show;
- (void)showWithView:(UIView *)view;
// 视图隐藏
-(void)dismiss;
//- (void)dismissForView;
//点击提交-视图隐藏
- (void)commitDismiss;
// 点击空白是否可隐藏视图(默认可隐藏)
@property (nonatomic,assign) BOOL isDismiss;
// 弹窗是否可叠加默认不可以
@property (nonatomic,assign) BOOL isSuperposition;

// 点击取消
@property (nonatomic,strong) void(^clickCancelBlock)(void);
@end

NS_ASSUME_NONNULL_END
