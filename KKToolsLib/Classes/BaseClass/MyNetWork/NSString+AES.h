//
//  NSString+AES.h
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
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES)

/** AES加密
 * @param content   需加密字符串
 */
+(NSString *)AES128_Encrypt:(NSString *)content;

/// AES解密
/// @param content 加密字符串
/// @param type 0:加密密钥使用KEY    1：加密密钥使用KEY2
+(NSData*)AES128_Decrypt:(NSString *)content type:(NSInteger)type;

/** adAES加密
 * @param content   需加密字符串
 */
+(NSString *)adAES128_Encrypt:(NSString *)content;


/** adAES解密
 * @param content   加密字符串
 */
+(NSData*)adAES128_Decrypt:(NSString *)content;


/** json封装 */
+(NSString *)convertToJsonData:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
