//
//  RootPopView.m
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
#import "AlertViewManager.h"
#import "YYKit/YYKit.h"
#import "UIColor+Hex.h"


@interface RootPopView(){
    
}

@end



@implementation RootPopView

- (instancetype)init{
    if (self = [super init]) {
        self.orientation = MyOrientation_Vert;
        self.myHorzMargin = 0;
        self.wrapContentHeight = YES;
        self.isDismiss = YES;
        switch (self.animationType) {
            case PopTypeCenter:
            {
                self.myCenterY = 0;
            }
                break;
            case PopTypeBottom:
            {
                self.myTop = kScreenHeight;
            }
                break;
                
            default:
                break;
        }
        
        self.btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        self.btnBack.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.5];
        [self.btnBack addTarget:self action:@selector(gotoBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnBack addSubview:self];
    }
    return self;
}

- (instancetype)initWithType:(PopType)type{
    self = [super init];
    if (self = [super init]) {
        self.orientation = MyOrientation_Vert;
        self.myHorzMargin = 0;
        self.wrapContentHeight = YES;
        self.animationType = type;
        self.isDismiss = YES;
        switch (self.animationType) {
            case PopTypeCenter:
            {
                self.myCenterY = 0;
            }
                break;
            case PopTypeBottom:
            {
                self.myTop = kScreenHeight;
            }
                break;
                
            default:
                break;
        }
//        [self setTarget:self action:@selector(dismiss)];
        self.btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        self.btnBack.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.5];
        [self.btnBack addTarget:self action:@selector(gotoBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnBack addSubview:self];
    }
    return self;
}




#pragma mark 触发事件
-(void)gotoBackBtnClick:(UIButton *)btn{
    if (self.isDismiss) {
        [self dismiss];
    }
}
-(void)show{
    if(self.isSuperposition){
        [[UIApplication sharedApplication].keyWindow addSubview:self.btnBack];
        switch (self.animationType) {
            case PopTypeCenter:
            {
                self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
                [UIView animateWithDuration:0.3 delay:0
                                    options: UIViewAnimationOptionBeginFromCurrentState
                                 animations: ^{
                    self.alpha = 1.0;
                    self.transform = CGAffineTransformMakeScale(1, 1);
                } completion:nil];
            }
                break;
            case PopTypeBottom:
            {
                [UIView animateWithDuration:0.3 animations:^{
                    self.alpha = 1.0;
                    CGSize sizeThatFits = [self sizeThatFits:CGSizeZero];
                    self.transform = CGAffineTransformMakeTranslation(0, -sizeThatFits.height);
                } completion:^(BOOL finished) {
                    
                }];
            }
                break;
            case PopTypeTop:
            {
                [UIView animateWithDuration:0.3 animations:^{
                    self.alpha = 1.0;
                    CGSize sizeThatFits = [self sizeThatFits:CGSizeZero];
                    self.transform = CGAffineTransformMakeTranslation(0, sizeThatFits.height);
                } completion:^(BOOL finished) {
                    
                }];
            }
                break;
                
            default:
                break;
        }
    }else{
        [[AlertViewManager shareManager] showWithExecuteBlock:^{
            [[UIApplication sharedApplication].keyWindow addSubview:self.btnBack];
            switch (self.animationType) {
                case PopTypeCenter:
                {
                    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
                    [UIView animateWithDuration:0.3 delay:0
                                        options: UIViewAnimationOptionBeginFromCurrentState
                                     animations: ^{
                        self.alpha = 1.0;
                        self.transform = CGAffineTransformMakeScale(1, 1);
                    } completion:nil];
                }
                    break;
                case PopTypeBottom:
                {
                    [UIView animateWithDuration:0.3 animations:^{
                        self.alpha = 1.0;
                        CGSize sizeThatFits = [self sizeThatFits:CGSizeZero];
                        self.transform = CGAffineTransformMakeTranslation(0, -sizeThatFits.height);
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                    break;
                case PopTypeTop:
                {
                    [UIView animateWithDuration:0.3 animations:^{
                        self.alpha = 1.0;
                        CGSize sizeThatFits = [self sizeThatFits:CGSizeZero];
                        self.transform = CGAffineTransformMakeTranslation(0, sizeThatFits.height);
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                    break;
                    
                default:
                    break;
            }
        }];
    }
    
}

- (void)showWithView:(UIView *)view{
    //    [[AlertViewManager shareManager] showWithExecuteBlock:^{
    [view addSubview:self.btnBack];
    switch (self.animationType) {
        case PopTypeCenter:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 1.0;
                self.transform = CGAffineTransformScale(self.transform, 1, 1);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case PopTypeBottom:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 1.0;
                CGSize sizeThatFits = [self sizeThatFits:CGSizeZero];
                self.transform = CGAffineTransformMakeTranslation(0, -sizeThatFits.height);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case PopTypeTop:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 1.0;
                CGSize sizeThatFits = [self sizeThatFits:CGSizeZero];
                self.transform = CGAffineTransformMakeTranslation(0, sizeThatFits.height);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        default:
            break;
    }
    //    }];
}



-(void)dismiss{
    [[AlertViewManager shareManager] dismissWithExecuteBlock:^{
        switch (self.animationType) {
            case PopTypeCenter:
            {
//                [UIView animateWithDuration:0.3 animations:^{
//                    self.transform = CGAffineTransformScale(self.transform, 0.1, 0.1);
//                    self.alpha = 0;
//                    self.btnBack.alpha = 0;
//                }completion:^(BOOL finished) {
//                    [self.btnBack removeFromSuperview];
//                    if (self.clickCancelBlock) {
//                        self.clickCancelBlock();
//                    }
//                }];
                self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                [UIView animateWithDuration:0.3 animations:^{
                    self.transform = CGAffineTransformScale(self.transform, 0.1, 0.1);
                    self.alpha = 0;
                    self.btnBack.alpha = 0;
                } completion:^(BOOL finished){
                    [self.btnBack removeFromSuperview];
                    if (self.clickCancelBlock) {
                        self.clickCancelBlock();
                    }
                }];
            }
                break;
            case PopTypeBottom:
            {
                [UIView animateWithDuration:0.3 animations:^{
                    self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
                    self.alpha = 0;
                    self.btnBack.alpha = 0;
                }completion:^(BOOL finished) {
                    [self.btnBack removeFromSuperview];
                    if (self.clickCancelBlock) {
                        self.clickCancelBlock();
                    }
                }];
            }
                break;
            case PopTypeTop:
            {
                [UIView animateWithDuration:0.3 animations:^{
                    self.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight);
                    self.alpha = 0;
                    self.btnBack.alpha = 0;
                }completion:^(BOOL finished) {
                    [self.btnBack removeFromSuperview];
                    if (self.clickCancelBlock) {
                        self.clickCancelBlock();
                    }
                }];
            }
                break;
                
            default:
                break;
        }
    }];
    
}

//- (void)dismissForView{
//    [[AlertViewManager shareManager] dismissHomeWithExecuteBlock:^{
//        switch (self.animationType) {
//            case PopTypeCenter:
//            {
//                [UIView animateWithDuration:0.3 animations:^{
//                    self.transform = CGAffineTransformScale(self.transform, 0.1, 0.1);
//                    self.alpha = 0;
//                }completion:^(BOOL finished) {
//                    [self.btnBack removeFromSuperview];
//                    if (self.clickCancelBlock) {
//                        self.clickCancelBlock();
//                    }
//                }];
//            }
//                break;
//            case PopTypeBottom:
//            {
//                [UIView animateWithDuration:0.3 animations:^{
//                    self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
//                    self.alpha = 0;
//                }completion:^(BOOL finished) {
//                    [self.btnBack removeFromSuperview];
//                    if (self.clickCancelBlock) {
//                        self.clickCancelBlock();
//                    }
//                }];
//            }
//                break;
//
//            default:
//                break;
//        }
//    }];
//}

- (void)commitDismiss{
    [[AlertViewManager shareManager] dismissWithExecuteBlock:^{
        switch (self.animationType) {
            case PopTypeCenter:
            {
                self.transform = CGAffineTransformScale(self.transform, 0.1, 0.1);
                self.alpha = 0;
                [self.btnBack removeFromSuperview];
            }
                break;
            case PopTypeBottom:
            {
                self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
                self.alpha = 0;
                [self.btnBack removeFromSuperview];
            }
                break;
            case PopTypeTop:
            {
                
            }
                break;
                
            default:
                break;
        }
        
    }];
}

#pragma mark - 懒加载


@end
