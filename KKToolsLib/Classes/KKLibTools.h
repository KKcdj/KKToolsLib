//
//  KKLibTools.h
//  haha
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
    

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , UserVipState) {
    UserVipStateNo = 0,// 非会员
    UserVipStateYes,// 会员
    UserVipStateRewards,//奖励会员
};

NS_ASSUME_NONNULL_BEGIN

@interface KKLibTools : NSObject
#pragma mark - 屏幕尺寸相关
/// 顶部安全区高度
+ (CGFloat)kk_safeDistanceTop;
/// 底部安全区高度
+ (CGFloat)kk_safeDistanceBottom;
/// 顶部状态栏高度（包括安全区）
+ (CGFloat)kk_statusBarHeight;
/// 导航栏高度
+ (CGFloat)kk_navigationBarHeight;
/// 状态栏+导航栏的高度
+ (CGFloat)kk_navigationFullHeight;
/// 底部导航栏高度
+ (CGFloat)kk_tabBarHeight;
/// 底部导航栏高度（包括安全区）
+ (CGFloat)kk_tabBarFullHeight;


#pragma mark - 字符串相关
/// 判断是否为空
+ (BOOL)isBlankString:(NSString *)string;
/// 数组、字典转jsonString
/// @param original 内容
+ (NSString *)arrayAndDicChangeJsonString:(id)original;
/// model转化为字典
+ (NSDictionary *)dicFromObject:(NSObject *)object;
/// 判断字符串是否是电话号码：
+ (BOOL)checkTelNumber:(NSString*)telNumber;
/// 判断字符串是否是邮箱地址：
+ (BOOL)isValidateEmail:(NSString *)email;

#pragma mark - 时间相关
/// 获取当前时间戳  （以毫秒为单位）
+ (NSString *)getNowTimeTimestamp;
/// 获取当前时间NSDate
+ (NSDate *)getCurrentTime;
/// 字符串转时间戳 如：2017-4-10 17:15:10
+ (NSString *)getTimeStrWithString:(NSString *)str;
/// 获取当前时间 小时：分钟
+ (NSString *)getNowTimeHHMM;
/// 获取当前时间 年月日
+ (NSString *)getNowTimeYYMMDD;
/// 多少分钟后的时间 小时：分钟
+ (NSString *)getNowTimeHHMMAtTime:(NSInteger)time;
/// 获取时区
+ (NSString *)returnTimeZone;
/// 传入 秒  得到 xx时 xx分钟xx秒
+ (NSString *)getHHMMSSFromTimerval:(NSString *)timerval;
+ (NSArray *)stringFromTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)getDDFromTimerval:(NSString *)timerval;
/// 时间戳 转日期 （yyyy-MM-dd）
+ (NSString *)timeWithYearMonthDayCountDown:(NSString *)timestamp;

#pragma mark - 图片相关
/// 截屏
+ (UIImage *)imageWithScreenContents:(UIView *)pageView;
/// 图片高斯模糊处理
+ (UIImage *)returnGaussianBlurImage:(UIImage *)image radius:(CGFloat)radius;

#pragma mark - 获取设备信息相关
/// 缓存大小
+ (CGFloat)folderSize;
///清理缓存
+ (void)removeCache;
/// 文件大小格式化
/// - Parameter size: 大小 返回值实例：1.22M
+ (NSString *)formatFileSize:(NSInteger)size;
/// 返回网络请求是需要的App版本号
+ (NSString *)returnHttpQuestAppVersion;
/// 返回数据库版本号
+ (NSString *)returnDatabaseSchemaVersion;
/// 获取语言代码如：en
+ (NSString *)returnLanguageCode;
/// 国家代码如：us（数据来源地区）
+ (NSString *)returnCountryCode;
/// 电话卡运营商代码如：310
+ (NSString *)returnCarrierCode;
///  获取iOS设备型号 该型号就是 设置->通用->关于手机->型号名称
+ (NSString *)returnCurrentDeviceModel;
/// 获取设备当前网络IP地址（是获取IPv4 还是 IPv6）
+ (NSString *)getIPAddress:(BOOL)preferIPv4;


#pragma mark - 其他
/// 是否开启VPN代理
+ (BOOL)isSettingVpnNetWork;

/// 获取应用主窗口
+ (UIWindow *)returnAppWindow;

/// 是否小屏手机
+ (BOOL)isMiniScreenIphone;
@end

NS_ASSUME_NONNULL_END
