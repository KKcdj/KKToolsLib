//
//  UUIDManager.m
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
    

#import "UUIDManager.h"
#import "KeyChainManager.h"

@implementation UUIDManager
+ (NSString *)getDeviceID{
    NSString *uuidStr = [KeyChainManager readDataFromKeyChain:@"device_uuid"];
    if ([uuidStr isEqualToString: @""] || !uuidStr) {
        // 生成uuid
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        BOOL saveStatu = [KeyChainManager keyChainSaveData:uuidStr withIdentifier:@"device_uuid"];
        if (saveStatu) {
            
        }
    }
    return uuidStr;
    
}
@end
