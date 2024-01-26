//
//  AdvertisementModel.h
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
    

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdvertisementModel : RLMObject
@property NSString *ID;

/// 0 = AdMob       4=AppLovin
@property NSString *type;

/// inter(大屏)、banner(横幅)、native(原生)、reward(激励)、open(开屏)
@property NSString *tag;

+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
