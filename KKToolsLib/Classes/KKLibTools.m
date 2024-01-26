//
//  KKLibTools.m
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
    

#import "KKLibTools.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import "NSBundle+Language.h"
#import <objc/message.h>
#import "KKLibObjectProperty.h"
#import "YYKit/YYKit.h"

#define IOS_CELLULAR    @"pdp_ip0"//有些分配的地址为en0 有些分配的en1
#define IOS_WIFI2       @"en2"
#define IOS_WIFI1       @"en1"
#define IOS_WIFI        @"en0"//
#define IOS_VPN       @"utun0"  vpn很少用到可以注释
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


@implementation KKLibTools
/// 顶部安全区高度
+ (CGFloat)kk_safeDistanceTop{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}

/// 底部安全区高度
+ (CGFloat)kk_safeDistanceBottom{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}

/// 顶部状态栏高度（包括安全区）
+ (CGFloat)kk_statusBarHeight{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

/// 导航栏高度
+ (CGFloat)kk_navigationBarHeight{
    return 44.0f;
}

/// 状态栏+导航栏的高度
+ (CGFloat)kk_navigationFullHeight{
    return [self kk_statusBarHeight] + [self kk_navigationBarHeight];
}

/// 底部导航栏高度
+ (CGFloat)kk_tabBarHeight{
    return 49.0f;
}

/// 底部导航栏高度（包括安全区）
+ (CGFloat)kk_tabBarFullHeight{
    return [self kk_tabBarHeight] + [self kk_safeDistanceBottom];
}

#pragma mark - 字符串相关
/// 判断是否为空
+ (BOOL)isBlankString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/// 数组、字典转jsonString
/// @param original 内容
+ (NSString *)arrayAndDicChangeJsonString:(id)original{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:original
                                                       options:NSJSONWritingSortedKeys
                                                         error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

/// model转化为字典
+ (NSDictionary *)dicFromObject:(NSObject *)object{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        unsigned int count;
        objc_property_t *propertyList = class_copyPropertyList([object class], &count);
        
        for (int i = 0; i < count; i++) {
            objc_property_t property = propertyList[i];
            const char *cName = property_getName(property);
            NSString *name = [NSString stringWithUTF8String:cName];
            NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
            
            if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:value forKey:name];
                
            } else if ([value isKindOfClass:[NSArray class]]) {
                //数组或字典
                [dic setObject:[self arrayWithObject:value] forKey:name];
            } else if ([value isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self dicWithObject:value] forKey:name];
            } else if (value == nil) {
                //null
                //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
            } else {
                //model
                [dic setObject:[self dicFromObject:value] forKey:name];
            }
        }
        
        return [dic copy];
}

+ (NSArray *)arrayWithObject:(id)object {
    //数组
    NSMutableArray *array = [NSMutableArray array];
    NSArray *originArr = (NSArray *)object;
    if ([originArr isKindOfClass:[NSArray class]]) {
        for (NSObject *object in originArr) {
            if ([object isKindOfClass:[NSString class]]||[object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
            } else if ([object isKindOfClass:[NSArray class]]) {
                //数组或字典
                [array addObject:[self arrayWithObject:object]];
            } else if ([object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self dicWithObject:object]];
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
        return [array copy];
    }
    return array.copy;
}

+ (NSDictionary *)dicWithObject:(id)object {
    //字典
    NSDictionary *originDic = (NSDictionary *)object;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([object isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            if ([object isKindOfClass:[NSString class]]||[object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
            } else if ([object isKindOfClass:[NSArray class]]) {
                //数组或字典
                [dic setObject:[self arrayWithObject:object] forKey:key];
            } else if ([object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self dicWithObject:object] forKey:key];
            } else {
                //model
                [dic setObject:[self dicFromObject:object] forKey:key];
            }
        }
        return [dic copy];
    }
    return dic.copy;
}

/// 文件大小格式化
/// - Parameter size: 大小 返回值实例：1.22M
+ (NSString *)formatFileSize:(NSInteger)size{
    if (size>0) {
        double kiloByte=size/1024.0;
        if (kiloByte < 1 && kiloByte > 0) {
            return [NSString stringWithFormat:@"%.2ldByte",(long)size];
        }
        
        double megaByte = kiloByte / 1024.0;
        if (megaByte < 1) {
            return [NSString stringWithFormat:@"%.2fK",kiloByte];
        }
        
        double gigaByte = megaByte / 1024.0;
        if (gigaByte < 1) {
            return [NSString stringWithFormat:@"%.2fM",megaByte];
        }
        
        double teraByte = gigaByte / 1024.0;
        if (teraByte < 1) {
            return [NSString stringWithFormat:@"%.2fG",gigaByte];
        }
        
        return [NSString stringWithFormat:@"%.2fT",teraByte];
    }
    return @"0K";
}

/// 根据key获取Info.plist文件内容
/// - Parameter key: key
+ (NSString *)URLSchemesForkey:(NSString *)key {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    return dict[key];
}

/// 生成随机数
/// - Parameter index: 不含index
/// - Parameter maxNum: 最大值
+ (NSInteger)arc4randomOnIndex:(NSInteger)index maxNum:(NSInteger)maxNum{
    if (maxNum == 1) {
        return 0;
    } else {
        NSInteger num = arc4random() % maxNum;
        if (num == index) {
            return [self arc4randomOnIndex:index maxNum:maxNum];
        } else {
            return num;
        }
    }
}

/// 判断字符串是否是电话号码：
+ (BOOL)checkTelNumber:(NSString*)telNumber{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    
    return isMatch;
}

/// 判断字符串是否是邮箱地址：
+(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

#pragma mark - 时间相关
/// 获取时区
+ (NSString *)returnTimeZone{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"z";
    return [dateFormatter stringFromDate:date];
}

//获取当前时间戳
+(NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

+ (NSDate *)getCurrentTime{
    return [NSDate new];
}
//字符串转时间戳 如：2017-4-10 17:15:10
+ (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

/// 获取当前时间 小时：分钟
+ (NSString *)getNowTimeHHMM{
    NSDate *timeDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *locationString = [dateFormatter stringFromDate:timeDate];
    return locationString;
}
/// 获取当前时间 年月日
+ (NSString *)getNowTimeYYMMDD{
    NSDate *timeDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *locationString = [dateFormatter stringFromDate:timeDate];
    return locationString;
}

/// 多少分钟后的时间 小时：分钟
+ (NSString *)getNowTimeHHMMAtTime:(NSInteger)time{
    NSDate *timeDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMinute:time];
    timeDate = [gregorian dateByAddingComponents:offsetComponents toDate:timeDate options:0];
    
    NSString *locationString = [dateFormatter stringFromDate:timeDate];
    
    return locationString;
}

/// 传入 秒  得到 xx时 xx分钟xx秒
+ (NSString *)getHHMMSSFromTimerval:(NSString *)timerval{
    NSInteger interval = [timerval integerValue];
    long seconds = interval % 60;
    long minutes = (interval / 60) % 60;
    long hours = (interval / 3600);
        
    return [NSString stringWithFormat:@"%0.2ld:%0.2ld:%0.2ld", hours, minutes, seconds];
}

+ (NSArray *)stringFromTimeInterval:(NSTimeInterval)timeInterval {
    NSInteger interval = timeInterval;
    long seconds = interval % 60;
    long minutes = (interval / 60) % 60;
    long hours = (interval / 3600);
    NSString *timeStr = [NSString stringWithFormat:@"%0.2ld%0.2ld%0.2ld", hours, minutes, seconds];
    NSRange theRange = {0, 1};
    NSMutableArray * array = [NSMutableArray array];
    for ( NSInteger i = 0; i < [timeStr length]; i++) {
        theRange.location = i;
        [array addObject:[timeStr substringWithRange:theRange]];
    }
    return [[array reverseObjectEnumerator] allObjects];
}
+ (NSString *)getDDFromTimerval:(NSString *)timerval{
    NSInteger interval = [timerval integerValue];
    float days = (interval / 86400.0);
        
    return [NSString stringWithFormat:@"%0.1f", days];
}
/// 时间戳 转日期 （yyyy-MM-dd）
+ (NSString *)timeWithYearMonthDayCountDown:(NSString *)timestamp{
    // 传入的时间戳timeStr如果是精确到毫秒的记得要/1000
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 实例化一个NSDateFormatter对象，设定时间格式，这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:detailDate];
    
    return dateStr;
}

#pragma mark - 图片相关
/// 截屏
+ (UIImage *)imageWithScreenContents:(UIView *)pageView{
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth, kScreenHeight-KK_tabBarFullHeight), YES, 1.0);
//    [pageView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return uiImage;
    
    //第一个参数表示区域大小 第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    CGSize size = CGSizeMake(kScreenWidth,kScreenHeight - [KKLibTools kk_tabBarFullHeight]);
//    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [pageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    
}

/// 图片高斯模糊处理
+ (UIImage *)returnGaussianBlurImage:(UIImage *)image radius:(CGFloat)radius{
    CIContext * context = [CIContext contextWithOptions:nil];//创建绘制空间
    CIImage * sourceImage = [CIImage imageWithCGImage:image.CGImage];//将图片转换成CIImage
    ///图片仿射滤镜
    CIFilter * clamp = [CIFilter filterWithName:@"CIAffineClamp"];//设置绘制类型
    [clamp setValue:sourceImage forKey:kCIInputImageKey];//设置要绘制的图片
    CIImage *clampResult = [clamp valueForKey:kCIOutputImageKey];
    ///高斯模糊滤镜
    CIFilter* gaussianBlur = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlur setValue:clampResult forKey:kCIInputImageKey];
    [gaussianBlur setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];//设置模糊值
    CIImage * gaussianBlurResult = [gaussianBlur valueForKey:kCIOutputImageKey];
    ///转化获取图片
    CGImageRef cgImage = [context createCGImage:gaussianBlurResult fromRect:[sourceImage extent]];
    UIImage * resultImage = [UIImage imageWithCGImage:cgImage];
    
    return resultImage;
}

#pragma mark - 获取设备信息相关
// 缓存大小
+ (CGFloat)folderSize{
    CGFloat folderSize = 0.0;
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    NSLog(@"文件数：%ld",files.count);
    for(NSString *path in files) {
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    if (isnan(sizeM)) {
        sizeM = 0.00;
    }
    return sizeM;
}

//清理缓存
+ (void)removeCache{
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    for(NSString *p in files){
        NSError*error;
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
                //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
            }else{
                NSLog(@"清除失败");
            }
        }
    }
}

/// 返回网络请求是需要的App版本号
+ (NSString *)returnHttpQuestAppVersion{
    return [KK_APP_VERSION stringByReplacingOccurrencesOfString:@"." withString:@""];
}
/// 返回数据库版本号
+ (NSString *)returnDatabaseSchemaVersion{
    return [[NSString stringWithFormat:@"%@.%@",KK_APP_VERSION,KK_APP_BUILD] stringByReplacingOccurrencesOfString:@"." withString:@""];
}

/// 获取语言代码如：en
+ (NSString *)returnLanguageCode{
    NSString *language = [[NSBundle mainBundle] preferredLocalizations][0];
    
    return language;
}

/// 国家代码如：us（数据来源地区）
+ (NSString *)returnCountryCode{
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode]; // get country code, e.g. ES (Spain), FR (France), etc.
    
    return countryCode;
}

/// 电话卡运营商代码如：310
+ (NSString *)returnCarrierCode{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = nil;
    NSString *radioType = nil;
    if (@available(iOS 12.1, *)) {
        if (info && [info respondsToSelector:@selector(serviceSubscriberCellularProviders)]) {
            NSDictionary *dic = [info serviceSubscriberCellularProviders];
            if (dic.allKeys.count) {
                carrier = [dic objectForKey:dic.allKeys[0]];
            }
        }
        if (info && [info respondsToSelector:@selector(serviceCurrentRadioAccessTechnology)]) {
            
            NSDictionary *radioDic = [info serviceCurrentRadioAccessTechnology];
            if (radioDic.allKeys.count) {
                radioType = [radioDic objectForKey:radioDic.allKeys[0]];
            }
        }
    }
    
    //运营商可用
//        BOOL use = carrier.allowsVOIP;
//    //    //运营商名字
//        NSString *name = carrier.carrierName;
//    //    //ISO国家代码
//        NSString *code = carrier.isoCountryCode;
//    //移动网络代码
//        NSString *mnc = [carrier mobileNetworkCode];
    
    //移动国家代码
    NSString *mcc = [carrier mobileCountryCode];
    
    //    NSLog(@"运营商名字:%@,ISO国家代码:%@,移动国家代码:%@,移动网络代码:%@",name,code,mcc,mnc);
    if (mcc) {
        return mcc;
    } else {
        return @"";
    }
}

/// 获取设备当前网络IP地址（是获取IPv4 还是 IPv6）
+ (NSString *)getIPAddress:(BOOL)preferIPv4{
    //从字典中按顺序查询 查询到不为空即停止（顺序为4G(3G)、Wi-Fi、局域网）
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_WIFI2 @"/" IP_ADDR_IPv4, IOS_WIFI1 @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv4] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_WIFI2 @"/" IP_ADDR_IPv6, IOS_WIFI1 @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv6] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
        address = addresses[key];
        if(address) *stop = YES;
    } ];
    return address ? address : @"0.0.0.0";
}

/// 获取所有相关IP信息
+ (NSDictionary *)getIPAddresses{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

///  获取iOS设备型号
+ (NSString *)returnCurrentDeviceModel{
    struct utsname systemInfo;
    
    if (uname(&systemInfo) < 0) {
        return @"";
    } else {
        // 获取设备标识Identifier
        NSString *deviceIdentifer = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        // 根据identifier去匹配到对应的型号名称
        NSString *modelName = [[self modelList] objectForKey:deviceIdentifer];
        return modelName?:@"";
    }
}

/// 只列出了iphone、ipad和simulator的型号，其他设备型号请到 https://www.theiphonewiki.com/wiki/Models 查看
+ (NSDictionary *)modelList {
    // @{identifier: name}
    return @{
        // iPhone
        @"iPhone1,1" : @"iPhone",
        @"iPhone1,2" : @"iPhone 3G",
        @"iPhone2,1" : @"iPhone 3GS",
        @"iPhone3,1" : @"iPhone 4",
        @"iPhone3,2" : @"iPhone 4",
        @"iPhone3,3" : @"iPhone 4",
        @"iPhone4,1" : @"iPhone 4S",
        @"iPhone5,1" : @"iPhone 5",
        @"iPhone5,2" : @"iPhone 5",
        @"iPhone5,3" : @"iPhone 5c",
        @"iPhone5,4" : @"iPhone 5c",
        @"iPhone6,1" : @"iPhone 5s",
        @"iPhone6,2" : @"iPhone 5s",
        @"iPhone7,2" : @"iPhone 6",
        @"iPhone7,1" : @"iPhone 6 Plus",
        @"iPhone8,1" : @"iPhone 6s",
        @"iPhone8,2" : @"iPhone 6s Plus",
        @"iPhone8,4" : @"iPhone SE (1st generation)",
        @"iPhone9,1" : @"iPhone 7",
        @"iPhone9,3" : @"iPhone 7",
        @"iPhone9,2" : @"iPhone 7 Plus",
        @"iPhone9,4" : @"iPhone 7 Plus",
        @"iPhone10,1" : @"iPhone 8",
        @"iPhone10,4" : @"iPhone 8",
        @"iPhone10,2" : @"iPhone 8 Plus",
        @"iPhone10,5" : @"iPhone 8 Plus",
        @"iPhone10,3" : @"iPhone X",
        @"iPhone10,6" : @"iPhone X",
        @"iPhone11,8" : @"iPhone XR",
        @"iPhone11,2" : @"iPhone XS",
        @"iPhone11,6" : @"iPhone XS Max",
        @"iPhone11,4" : @"iPhone XS Max",
        @"iPhone12,1" : @"iPhone 11",
        @"iPhone12,3" : @"iPhone 11 Pro",
        @"iPhone12,5" : @"iPhone 11 Pro Max",
        @"iPhone12,8" : @"iPhone SE (2nd generation)",
        @"iPhone13,1" : @"iPhone 12 mini",
        @"iPhone13,2" : @"iPhone 12",
        @"iPhone13,3" : @"iPhone 12 Pro",
        @"iPhone13,4" : @"iPhone 12 Pro Max",
        @"iPhone14,4" : @"iPhone 13 mini",
        @"iPhone14,5" : @"iPhone 13",
        @"iPhone14,2" : @"iPhone 13 Pro",
        @"iPhone14,3" : @"iPhone 13 Pro Max",
        @"iPhone14,6" : @"iPhone SE (3rd generation)",
        @"iPhone14,7" : @"iPhone 14",
        @"iPhone14,8" : @"iPhone 14 Plus",
        @"iPhone15,2" : @"iPhone 14 Pro",
        @"iPhone15,3" : @"iPhone 14 Pro Max",
        @"iPhone15,4" : @"iPhone 15",
        @"iPhone15,5" : @"iPhone 15 Plus",
        @"iPhone16,1" : @"iPhone 15 Pro",
        @"iPhone16,2" : @"iPhone 15 Pro Max",


        // iPad
        @"iPad1,1" : @"iPad",
        @"iPad2,1" : @"iPad 2",
        @"iPad2,2" : @"iPad 2",
        @"iPad2,3" : @"iPad 2",
        @"iPad2,4" : @"iPad 2",
        @"iPad3,1" : @"iPad (3rd generation)",
        @"iPad3,2" : @"iPad (3rd generation)",
        @"iPad3,3" : @"iPad (3rd generation)",
        @"iPad3,4" : @"iPad (4th generation)",
        @"iPad3,5" : @"iPad (4th generation)",
        @"iPad3,6" : @"iPad (4th generation)",
        @"iPad6,11" : @"iPad (5th generation)",
        @"iPad6,12" : @"iPad (5th generation)",
        @"iPad7,5" : @"iPad (6th generation)",
        @"iPad7,6" : @"iPad (6th generation)",
        @"iPad7,11" : @"iPad (7th generation)",
        @"iPad7,12" : @"iPad (7th generation)",
        @"iPad11,6" : @"iPad (8th generation)",
        @"iPad11,7" : @"iPad (8th generation)",
        @"iPad12,1" : @"iPad (9th generation)",
        @"iPad12,2" : @"iPad (9th generation)",
        @"iPad4,1" : @"iPad Air",
        @"iPad4,2" : @"iPad Air",
        @"iPad4,3" : @"iPad Air",
        @"iPad5,3" : @"iPad Air 2",
        @"iPad5,4" : @"iPad Air 2",
        @"iPad11,3" : @"iPad Air (3rd generation)",
        @"iPad11,4" : @"iPad Air (3rd generation)",
        @"iPad13,1" : @"iPad Air (4th generation)",
        @"iPad13,2" : @"iPad Air (4th generation)",
        @"iPad13,16" : @"iPad Air (5th generation)",
        @"iPad13,17" : @"iPad Air (5th generation)",
        @"iPad6,7" : @"iPad Pro (12.9-inch)",
        @"iPad6,8" : @"iPad Pro (12.9-inch)",
        @"iPad6,3" : @"iPad Pro (9.7-inch)",
        @"iPad6,4" : @"iPad Pro (9.7-inch)",
        @"iPad7,1" : @"iPad Pro (12.9-inch) (2nd generation)",
        @"iPad7,2" : @"iPad Pro (12.9-inch) (2nd generation)",
        @"iPad7,3" : @"iPad Pro (10.5-inch)",
        @"iPad7,4" : @"iPad Pro (10.5-inch)",
        @"iPad8,1" : @"iPad Pro (11-inch)",
        @"iPad8,2" : @"iPad Pro (11-inch)",
        @"iPad8,3" : @"iPad Pro (11-inch)",
        @"iPad8,4" : @"iPad Pro (11-inch)",
        @"iPad8,5" : @"iPad Pro (12.9-inch) (3rd generation)",
        @"iPad8,6" : @"iPad Pro (12.9-inch) (3rd generation)",
        @"iPad8,7" : @"iPad Pro (12.9-inch) (3rd generation)",
        @"iPad8,8" : @"iPad Pro (12.9-inch) (3rd generation)",
        @"iPad8,9" : @"iPad Pro (11-inch) (2nd generation)",
        @"iPad8,10" : @"iPad Pro (11-inch) (2nd generation)",
        @"iPad8,11" : @"iPad Pro (12.9-inch) (4th generation)",
        @"iPad8,12" : @"iPad Pro (12.9-inch) (4th generation)",
        @"iPad13,4" : @"iPad Pro (11-inch) (3rd generation)",
        @"iPad13,5" : @"iPad Pro (11-inch) (3rd generation)",
        @"iPad13,6" : @"iPad Pro (11-inch) (3rd generation)",
        @"iPad13,7" : @"iPad Pro (11-inch) (3rd generation)",
        @"iPad13,8" : @"iPad Pro (12.9-inch) (5th generation)",
        @"iPad13,9" : @"iPad Pro (12.9-inch) (5th generation)",
        @"iPad13,10" : @"iPad Pro (12.9-inch) (5th generation)",
        @"iPad13,11" : @"iPad Pro (12.9-inch) (5th generation)",
        @"iPad2,5" : @"iPad mini",
        @"iPad2,6" : @"iPad mini",
        @"iPad2,7" : @"iPad mini",
        @"iPad4,4" : @"iPad mini 2",
        @"iPad4,5" : @"iPad mini 2",
        @"iPad4,6" : @"iPad mini 2",
        @"iPad4,7" : @"iPad mini 3",
        @"iPad4,8" : @"iPad mini 3",
        @"iPad4,9" : @"iPad mini 3",
        @"iPad5,1" : @"iPad mini 4",
        @"iPad5,2" : @"iPad mini 4",
        @"iPad11,1" : @"iPad mini (5th generation)",
        @"iPad11,2" : @"iPad mini (5th generation)",
        @"iPad14,1" : @"iPad mini (6th generation)",
        @"iPad14,2" : @"iPad mini (6th generation)",
        // 其他
        @"i386" : @"iPhone Simulator",
        @"x86_64" : @"iPhone Simulator",
    };
}




#pragma mark - 其他

/// 是否开启VPN代理
+ (BOOL)isSettingVpnNetWork{
    BOOL flag = NO;
    NSString *version = [UIDevice currentDevice].systemVersion;
    // need two ways to judge this.
    if (version.doubleValue >= 9.0)
    {
        NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
        NSArray *keys = [dict[@"__SCOPED__"] allKeys];
        for (NSString *key in keys) {
            if ([key rangeOfString:@"tap"].location != NSNotFound ||
                [key rangeOfString:@"tun"].location != NSNotFound ||
                [key rangeOfString:@"ipsec"].location != NSNotFound ||
                [key rangeOfString:@"ppp"].location != NSNotFound){
                flag = YES;
                break;
            }
        }
    }
    else
    {
        struct ifaddrs *interfaces = NULL;
        struct ifaddrs *temp_addr = NULL;
        int success = 0;

        // retrieve the current interfaces - returns 0 on success
        success = getifaddrs(&interfaces);
        if (success == 0)
        {
            // Loop through linked list of interfaces
            temp_addr = interfaces;
            while (temp_addr != NULL)
            {
                NSString *string = [NSString stringWithFormat:@"%s" , temp_addr->ifa_name];
                if ([string rangeOfString:@"tap"].location != NSNotFound ||
                    [string rangeOfString:@"tun"].location != NSNotFound ||
                    [string rangeOfString:@"ipsec"].location != NSNotFound ||
                    [string rangeOfString:@"ppp"].location != NSNotFound)
                {
                    flag = YES;
                    break;
                }
                temp_addr = temp_addr->ifa_next;
            }
        }

        // Free memory
        freeifaddrs(interfaces);
    }

    return flag;
}
/// 获取应用主窗口
+ (UIWindow *)returnAppWindow{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}



/// 是否小屏手机
+ (BOOL)isMiniScreenIphone{
    if ([[KKLibTools returnCurrentDeviceModel] isEqualToString:@"iPhone 5"] ||
        [[KKLibTools returnCurrentDeviceModel] isEqualToString:@"iPhone 5c"] ||
        [[KKLibTools returnCurrentDeviceModel] isEqualToString:@"iPhone 5s"] ||
        [[KKLibTools returnCurrentDeviceModel] isEqualToString:@"iPhone 6"] ||
        [[KKLibTools returnCurrentDeviceModel] isEqualToString:@"iPhone 6s"] ||
        [[KKLibTools returnCurrentDeviceModel] isEqualToString:@"iPhone SE (1st generation)"] ||
        [[KKLibTools returnCurrentDeviceModel] isEqualToString:@"iPhone 7"] ||
        [[KKLibTools returnCurrentDeviceModel] isEqualToString:@"iPhone 8"]
        ) {
        return YES;
    }
    
    
    return NO;
}
@end
