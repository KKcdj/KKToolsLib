#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AppRoutes.h"
#import "NSBundle+Language.h"
#import "UIColor+Hex.h"
#import "KeyChainManager.h"
#import "UUIDManager.h"
#import "KKTimer.h"
#import "AdvertisementModel.h"
#import "AppLanguageModel.h"
#import "AppProductsModel.h"
#import "AppRecordModel.h"
#import "ConfigInitModel.h"
#import "CurrentVipModel.h"
#import "LogEventModel.h"
#import "MusicListModel.h"
#import "MusicListTypeModel.h"
#import "MusicModel.h"
#import "KKNetworkAccessibility.h"
#import "MyNetWorkManagement.h"
#import "NSJSONSerialization+JSON.h"
#import "NSString+AES.h"
#import "AlertActionPopView.h"
#import "AlertViewManager.h"
#import "RootPopView.h"
#import "Toast.h"
#import "KKNavigationController.h"
#import "KKTabBarController.h"
#import "KKViewController.h"
#import "WKAppManager.h"
#import "Environment.h"
#import "KKToolsLib.h"
#import "ObjectProperty.h"
#import "DatabaseUtils.h"
#import "HttpUtils.h"
#import "KKAudioPlayer.h"
#import "KKTools.h"

FOUNDATION_EXPORT double KKToolsLibVersionNumber;
FOUNDATION_EXPORT const unsigned char KKToolsLibVersionString[];

