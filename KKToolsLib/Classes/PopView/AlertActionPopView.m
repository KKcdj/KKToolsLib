//
//  AlertActionPopView.m
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
    

#import "AlertActionPopView.h"
#import "MyLayout/MyLayout.h"
#import "UIColor+Hex.h"
#import "YYKit/YYKit.h"
#import "KKLibObjectProperty.h"

@implementation AlertActionPopView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message commit:(NSString *)commitStr{
    if(self = [super initWithType:(PopTypeCenter)]){
        self.title = title;
        self.message = message;
        self.commitStr = commitStr;
        [self e2004_initUI];
    }
    return self;
}



#pragma mark - 绘制页面布局
- (void)e2004_initUI{
    MyRelativeLayout *rootLL = [MyRelativeLayout new];
    rootLL.heightSize.equalTo(@(MyLayoutSize.wrap));
    rootLL.myHorzMargin = 30;
    rootLL.centerXPos.equalTo(@0);
    rootLL.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    rootLL.layer.cornerRadius = 9;
    rootLL.layer.masksToBounds = YES;
    [self addSubview:rootLL];
    
    
    UILabel *titleL = [UILabel new];
    titleL.text = self.title;
    titleL.font  = [UIFont boldSystemFontOfSize:19];
    titleL.textColor = [UIColor colorWithHexString:@"181818" alpha:1];
    titleL.myHorzMargin = 20;
    titleL.heightSize.equalTo(@(MyLayoutSize.wrap));
    titleL.centerXPos.equalTo(@0);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.topPos.equalTo(@0).offset(25);
    [rootLL addSubview:titleL];
    
    UILabel *messageL = [UILabel new];
    messageL.text = self.message;
    messageL.textColor = [UIColor colorWithHexString:@"181818" alpha:0.8];
    messageL.font = [UIFont systemFontOfSize:15];
    messageL.myHorzMargin = 15;
    messageL.numberOfLines = 0;
    messageL.wrapContentHeight = YES;
    messageL.textAlignment = NSTextAlignmentCenter;
    messageL.topPos.equalTo(titleL.bottomPos).offset(14);
    messageL.centerXPos.equalTo(@0);
    [rootLL addSubview:messageL];
    
    MyLinearLayout *relative1RL = [MyLinearLayout linearLayoutWithOrientation:(MyOrientation_Horz)];
    relative1RL.myHeight = 44;
    relative1RL.myHorzMargin = 0;
    relative1RL.topPos.equalTo(messageL.bottomPos).offset(30);
    [rootLL addSubview:relative1RL];
    {
        UIButton *cancelB = [UIButton new];
        cancelB.myHeight = 44;
        cancelB.weight = 1;
        [cancelB setTitle:KK_LocalizedString(@"取消") forState:0];
        [cancelB setTitleColor:[UIColor colorWithHexString:@"181818" alpha:0.6] forState:0];
        cancelB.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelB setTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
        [relative1RL addSubview:cancelB];
        
        UIView *lineV = [UIView new];
        lineV.size = CGSizeMake(1, 44);
        lineV.leftPos.equalTo(cancelB.rightPos);
        lineV.backgroundColor = [UIColor colorWithHexString:@"181818" alpha:0.1];
        [relative1RL addSubview:lineV];
        
        UIButton *commitB = [UIButton new];
        commitB.myHeight = 44;
        commitB.weight = 1;
        [commitB setTitle:self.commitStr forState:0];
        [commitB setTitleColor:KK_MainColor forState:0];
        commitB.rightPos.equalTo(@0);
        commitB.titleLabel.font = [UIFont systemFontOfSize:15];
        [commitB addTarget:self action:@selector(e2004_clickCommitButEvent) forControlEvents:(UIControlEventTouchUpInside)];
        [relative1RL addSubview:commitB];
    }
    
    UIView *lineV = [UIView new];
    lineV.myHorzMargin = 0;
    lineV.heightSize.equalTo(@1);
    lineV.bottomPos.equalTo(relative1RL.topPos);
    lineV.backgroundColor = [UIColor colorWithHexString:@"181818" alpha:0.1];
    [rootLL addSubview:lineV];
}



- (void)e2004_clickCommitButEvent{
    if(self.alertActionPopViewCommitBlock){
        [self commitDismiss];
        self.alertActionPopViewCommitBlock();
    }
}

@end
