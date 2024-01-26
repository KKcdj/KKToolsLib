//
//  KKViewController.m
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
    

#import "KKViewController.h"

@interface KKViewController ()<UIGestureRecognizerDelegate>{
    
}

@end

@implementation KKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 当你重写 self.navigationItem.leftBarButtonItem 之后，自带的返回按钮就会被覆盖，右滑返回就会失效，解决办法只要加入下面这句代码即可。
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
    [self initBaseUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



#pragma mark - 绘制页面布局
- (void)initBaseUI{
    MyLinearLayout *rootView = [MyLinearLayout linearLayoutWithOrientation:(MyOrientation_Vert)];
    rootView.mySize = CGSizeMake(kScreenWidth, kScreenHeight);
    rootView.insetsPaddingFromSafeArea = UIRectEdgeNone;
    self.rootLayoutView = rootView;
    self.view = self.rootLayoutView;
    self.view.layer.masksToBounds = YES;
    
    
    MyRelativeLayout *layoutView = [MyRelativeLayout new];
    layoutView.myHorzMargin = 0;
    layoutView.weight = 1;
    layoutView.backgroundColor = KK_BGMainColor;
    [rootView addSubview:layoutView];
    self.layoutView = layoutView;
}

@end
