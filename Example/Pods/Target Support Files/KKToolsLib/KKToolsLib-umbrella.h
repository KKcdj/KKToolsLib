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

#import "NSBundle+Language.h"
#import "UIColor+Hex.h"
#import "KeyChainManager.h"
#import "UUIDManager.h"
#import "KKNetworkAccessibility.h"
#import "MyNetWorkManagement.h"
#import "NSJSONSerialization+JSON.h"
#import "NSString+AES.h"
#import "Toast.h"
#import "WKAppManager.h"
#import "KKTools.h"

FOUNDATION_EXPORT double KKToolsLibVersionNumber;
FOUNDATION_EXPORT const unsigned char KKToolsLibVersionString[];

