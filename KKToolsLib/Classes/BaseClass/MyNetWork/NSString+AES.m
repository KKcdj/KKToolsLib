//
//  NSString+AES.m
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
    

#import "NSString+AES.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>



#define     LocalStr_None           @""
  
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (AES)
/** AES加密
 * @param content   需加密字符串
 */
+(NSString *)AES128_Encrypt:(NSString *)content {
    
    NSData *decodedData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *AESData = [self AES128Decrypt:kCCEncrypt
                                     data:decodedData
                                      key:Https_KEY
                                       iv:Https_IV];
    NSString *base64EncodeStr = [self base64EncodedStringFrom:AESData];
    
    return base64EncodeStr;
}

/// AES解密
/// @param content 加密字符串
/// @param type 0:加密密钥使用Https_KEY：加密密钥使用Https_AD_KEY
+(NSData*)AES128_Decrypt:(NSString *)content type:(NSInteger)type{
    NSData *encryptedData = [self safeUrlBase64Decode:content];
    NSData *AESData;
    if(type == 0){
       AESData = [self AES128Decrypt:kCCDecrypt
                                         data:encryptedData
                                          key:Https_KEY
                                           iv:Https_IV];
    }else{
        AESData = [self AES128Decrypt:kCCDecrypt
                                          data:encryptedData
                                           key:Https_AD_KEY
                                            iv:Https_IV];
    }
    return AESData;
}

/**
 *  AES加解密算法
 *
 *  @param operation kCCEncrypt（加密）kCCDecrypt（解密）
 *  @param data      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 *
 *
 */
+ (NSData *)AES128Decrypt:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    
    char keyPtr[kCCKeySizeAES256 + 1];  //kCCKeySizeAES128是加密位数 可以替换成256位的
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 设置加密参数
    /**
     这里设置的加密方式是ECB，如果需要其他加密方式如CBC，把kCCOptionPKCS7Padding | kCCOptionECBMode这个参数修改成kCCOptionPKCS7Padding，，同时记得修改上边的偏移量，因为CBC模式有偏移量之说
     
     */
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES256,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess) {

        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    } else {
//        WFPrintf(@"Error");
    }
    
    free(buffer);
    return nil;
}

#pragma mark - 将saveBase64编码中的"-"，"_"字符串转换成"+"，"/"，字符串长度余4倍的位补"="
+(NSData*)safeUrlBase64Decode:(NSString*)safeUrlbase64Str {
    // '-' -> '+'
    // '_' -> '/'
    // 不足4倍长度，补'='
    safeUrlbase64Str = [safeUrlbase64Str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    safeUrlbase64Str = [safeUrlbase64Str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString * base64Str = [[NSMutableString alloc]initWithString:safeUrlbase64Str];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSInteger mod4 = base64Str.length % 4;
    if(mod4 > 0)
        [base64Str appendString:[@"====" substringToIndex:(4-mod4)]];
    //NSLog(@"Base64原文：%@", base64Str);
    
    NSData *encryptedData = [self base64DataCode:base64Str];
    
    return encryptedData;
    
}

+(NSData *)base64DataCode:(NSString *)string {
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    if (string == nil) {
        return [NSData data];
    }
    ixtext = 0;
    tempcstring = (const unsigned char *)[string UTF8String];
    lentext = [string length];
    theData = [NSMutableData dataWithCapacity: lentext];
    ixinbuf = 0;
    while (true) {
        if (ixtext >= lentext) {
            break;
        }
        ch = tempcstring [ixtext++];
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        }
        else if (ch == '+') {
            ch = 62;
        }
        else if (ch == '=') {
            flendtext = true;
        }
        else if (ch == '/') {
            ch = 63;
        }
        else {
            flignore = true;
        }
        
        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                }
                else {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return theData;
}

+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
      
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
      
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
          
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
      
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

+(NSString *)convertToJsonData:(NSDictionary *)dictionary
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//    NSRange range = {0,jsonString.length};
//
//    //去掉字符串中的空格
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    NSRange range2 = {0,mutStr.length};
//
//    //去掉字符串中的换行符
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

+(NSString *)adAES128_Encrypt:(NSString *)content
{
    NSData *decodedData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *AESData = [self AES128Decrypt:kCCEncrypt
                                     data:decodedData
                                      key:@"b23c52f6f9e34c78da3829adbf7d0923"
                                       iv:Https_IV];
    NSString *base64EncodeStr = [self base64EncodedStringFrom:AESData];
    
    return base64EncodeStr;
}

+(NSData*)adAES128_Decrypt:(NSString *)content
{
    NSData *encryptedData = [self safeUrlBase64Decode:content];
    NSData *AESData = [self AES128Decrypt:kCCDecrypt
                                     data:encryptedData
                                      key:@"b23c52f6f9e34c78da3829adbf7d0923"
                                       iv:Https_IV];
    return AESData;
}

@end
