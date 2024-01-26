//
//  KKLibObjectProperty.h
//  WidgetDemo
//  
//  Created by 陈德军 on 2024/1/26.
//  Copyright ©合肥维方科技有限公司. All rights reserved.
//  
//                      ____   ____      __
//                     / ___\ / _  \    / /
//                    / /    / / / /   / /
//                   / /___ / /_/ /?__/ /
//                  /_ -_-_/____,‘\____/
//
//
    

#ifndef KKLibObjectProperty_h
#define KKLibObjectProperty_h


//MARK: - 字体
#define KK_Semibold @"PingFangSC-Semibold"
#define KK_Medium @"PingFangSC-Medium"
#define KK_Regular @"PingFangSC-Regular"
#define KK_Light @"PingFangSC-Light"

//MARK: 常用颜色值
#define KK_MainColor [UIColor colorWithHexString:@"#185bff"]
#define KK_BGMainColor [UIColor colorWithHexString:@"#f5f5f6"]
#define KK_TextColor [UIColor colorWithHexString:@"#666666"]
#define KK_66Color [UIColor colorWithHexString:@"#666666"]
#define KK_33Color [UIColor colorWithHexString:@"#333333"]
#define KK_99Color [UIColor colorWithHexString:@"#999999"]
#define KK_ffColor [UIColor colorWithHexString:@"#ffffff"]



//MARK: 本地固化
/// 内购原始订单ID，只保留最后一次
#define KK_StoreKitiOginalTransactionId @"KK_StoreKitiOginalTransactionId"
/// 记录最后一次VIP开通数据
#define KK_StoreKitiOginalData @"KK_StoreKitiOginalData"



//MARK: - 屏幕尺寸相关
/// 顶部安全区高度
#define KK_topSafeDistance [KKLibTools kk_safeDistanceTop]
/// 底部安全区高度
#define KK_bottomSafeDistance [KKLibTools kk_safeDistanceBottom]
/// 顶部状态栏高度（包括安全区）
#define KK_statusBarHeight [KKLibTools kk_statusBarHeight]
/// 导航栏高度
#define KK_navigationBarHeight [KKLibTools kk_navigationBarHeight]
/// 状态栏+导航栏的高度
#define KK_navigationFullHeight [KKLibTools kk_navigationFullHeight]
/// 底部导航栏高度
#define KK_tabBarHeight [KKLibTools kk_tabBarHeight]
/// 底部导航栏高度（包括安全区）
#define KK_tabBarFullHeight [KKLibTools kk_tabBarFullHeight]

#define KK_returnAppWindow [KKLibTools returnAppWindow]

//底部横幅广告高度
#define KK_BannerAd_Height  50



//MARK: 通知中心
// 语言切换通知
#define KK_NotificationCenter_ChangeAppLanguage @"KK_NotificationCenter_ChangeAppLanguage"


//MARK: 语言本地化
#define KK_LocalizedString(string) NSLocalizedString(string, nil)



//MARK: 获取App基本信息
/** 获取APP名称 */
#define KK_APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
/** 程序版本号 */
#define KK_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 获取APP build版本 */
#define KK_APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])



#define KKLog(FORMAT, ...) NSLog(@"debugLogClass:%s ==> Line:%d \n%@\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])


#define KKWeakSelf __weak typeof(self) weakSelf = self;

// 获取变量名称
#define KK_VarNameToVar(_var) \
(NSString *)^(void){ \
    NSString *name = @#_var; \
    [NSString stringWithFormat:@"%@",_var]; \
    NSArray *tmpArr = [name componentsSeparatedByString:@"."];\
    return tmpArr.lastObject;\
}()


#endif /* KKLibObjectProperty_h */
