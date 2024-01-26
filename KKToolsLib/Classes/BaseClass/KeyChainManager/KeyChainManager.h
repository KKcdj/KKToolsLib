//
//  KeyChainManager.h
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

@interface KeyChainManager : NSObject
+ (instancetype)sharedManager;

/*
 保存数据
 
 @data  要存储的数据
 @identifier 存储数据的标示
 */
+(BOOL)keyChainSaveData:(id)data withIdentifier:(NSString*)identifier;

/*
 读取数据
 
 @identifier 存储数据的标示
 */
+(id)readDataFromKeyChain:(NSString*)identifier;

/*
 更新数据
 
 @data  要更新的数据
 @identifier 数据存储时的标示
 */
+(BOOL)updataForKeyChain:(id)data withIdentifier:(NSString*)identifier;

/*
 删除数据
 
 @identifier 数据存储时的标示
 */
+(void)keyChainDelete:(NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
