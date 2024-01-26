//
//  Environment.h
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
    

#ifndef Environment_h
#define Environment_h


/***********************************开发环境配置*********************************/

// 本地配置文件名称
#define BasicdataFileName     @"basicdata"
// 通用配置接口域名
#define API_CONFIG_HTTPS     @"https://api.musicatfdc.com/"
// 后台接口域名
#define API_BACKEND_HTTPS     @"https://cmd.musicatfdc.com/"
//appid
#define KKAppID @"6464159567"
//网络请求加密密钥
#define Https_KEY @"4a483a883140c9f15e442d30f03bdbd3"
#define Https_AD_KEY @"b23c52f6f9e34c78da3829adbf7d0923"
#define Https_IV  @"0000000000000000"
//内购校验地址
#define StoreKitVerifyReceipt @"https://sandbox.itunes.apple.com/verifyReceipt"
//内购验证共享密码
#define StoreKitVerifyReceiptPassword @"1723b8a145ac4005bf1f0b9b8ec5571c"
//是否沙盒
#define KK_isSandbox  @"0"
//内购Store Server API地址
#define API_StoreServerHTTP @"https://api.storekit-sandbox.itunes.apple.com/"
// 组ID
#define APPGroupID     @"group.KRJ9PUFCMT.group.com.empty.vpn"


/***********************************线上环境配置*********************************/


//// 本地配置文件名称
//#define BasicdataFileName     @"basicdata_Release"
//// 通用配置接口域名
//#define API_CONFIG_HTTPS     @"https://sflj.superfreellc.com/"
//// 后台接口域名
//#define API_BACKEND_HTTPS     @"https://apld.superfreellc.com/"
////appid
//#define KKAppID @"6474164803"
////网络请求加密密钥
//#define Https_KEY @"1d5cd71b48b01d8b5a0801a70459a108"
//#define Https_AD_KEY @"b23c52f6f9e34c78da3829adbf7d0923"
//#define Https_IV  @"0000000000000000"
////内购校验地址
//#define StoreKitVerifyReceipt @"https://sandbox.itunes.apple.com/verifyReceipt"
////内购验证共享密码
//#define StoreKitVerifyReceiptPassword @"a8b61c8ec0f7456cb5304dc107321188"
////是否沙盒
//#define KK_isSandbox  @"0"
////内购Store Server API地址
//#define API_StoreServerHTTP @"https://api.storekit-sandbox.itunes.apple.com/"
//// 组ID
//#define APPGroupID     @"group.T6PU3F7Q94.com.vpn.proxy.vpn.super.vpn"



#endif /* Environment_h */
