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

#import "AAKKToolsLib.h"
#import "AppLanguageModel.h"
#import "KeyChainManager.h"
#import "UUIDManager.h"
#import "KKLibObjectProperty.h"
#import "KKLibTools.h"
#import "NSBundle+Language.h"
#import "AlertActionPopView.h"
#import "AlertViewManager.h"
#import "RootPopView.h"
#import "Toast.h"
#import "UIColor+Hex.h"
#import "WKAppManager.h"

FOUNDATION_EXPORT double KKToolsLibVersionNumber;
FOUNDATION_EXPORT const unsigned char KKToolsLibVersionString[];

