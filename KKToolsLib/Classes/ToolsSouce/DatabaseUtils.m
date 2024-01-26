//
//  DatabaseUtils.m
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


#import "DatabaseUtils.h"
#import "NSBundle+Language.h"
#import "MusicListTypeModel.h"



// 歌单类型-默认
NSString *const MusicListTypeDefultPrimaryKey = @"000000";
// 歌单类型-自建
NSString *const MusicListTypeSelfPrimaryKey = @"000001";
// 歌单类型-收藏
NSString *const MusicListTypeCollectionPrimaryKey = @"000002";
// 歌单类型-最近播放
NSString *const MusicListTypeRecentlyPlayedPrimaryKey = @"000003";



// 默认歌单-收藏
NSString *const MusicListCollectionPrimaryKey = @"000000";
// 默认歌单-最近播放
NSString *const MusicListRecentlyPlayedPrimaryKey = @"000001";
// 默认歌单-下载
// 默认歌单-删除

@implementation DatabaseUtils
#pragma mark - app多语言接口
/// 获取多语言数组
+(RLMResults *)queryMultilingualData{
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageCode = @"en";
    if(appLanguages.firstObject){
        NSString *tmpstr = appLanguages.firstObject;
        languageCode = [tmpstr substringToIndex:tmpstr.length-3];
    }
    __block RLMResults *langs = [AppLanguageModel allObjects];
    if (langs.count == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:BasicdataFileName ofType:@"json"];
        if([KKTools isBlankString:path]){// 本地数据获取失败
            return langs;
        }
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *datas = [rootDict objectForKey:@"langs"];
        NSMutableArray<AppLanguageModel *> *marr = [NSMutableArray new];
        for (int i=0; i < datas.count; i++) {
            AppLanguageModel *model = [AppLanguageModel modelWithJSON:datas[i]];
            model.is_select = NO;
            if ([model.language_text isEqualToString:@"跟随系统"]){
                model.language_key = languageCode;
                model.is_select = YES;
            }
            [marr addObject:model];
        }
        
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] addOrUpdateObjects:marr];
        }];
        
        return langs;
    }else{
        return langs;
    }
}
/// 更新使用的语言
/// - Parameter primaryKey: 主健
+(BOOL)changeCurrentUserMultilingual:(NSString *)primaryKey{
    RLMResults<AppLanguageModel *> *newlangs = [AppLanguageModel objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([AppLanguageModel shareInstance].primaryKey),primaryKey]];
    if(newlangs.firstObject){
        RLMResults<AppLanguageModel *> *lodlangs = [AppLanguageModel objectsWhere:[NSString stringWithFormat:@"%@ = 1",KK_VarNameToVar([AppLanguageModel shareInstance].is_select)]];
        if(lodlangs.firstObject){
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                lodlangs.firstObject.is_select = NO;
                newlangs.firstObject.is_select = YES;
            }];
            
            [NSBundle setAppLanguage:newlangs.firstObject.language_key];
            return YES;
        }
    }
    
    return NO;
}
/// 获取当前使用的语言
+(RLMResults *)queryCurrentUserMultilingual{
    RLMResults<AppLanguageModel *> *langs = [AppLanguageModel objectsWhere:[NSString stringWithFormat:@"%@ = 1",KK_VarNameToVar([AppLanguageModel shareInstance].is_select)]];
    [NSBundle setAppLanguage:langs.firstObject.language_key];
    
    return langs;
}
/// 查询是否支持此语言
/// - Parameter language_key: 语言代码
+(BOOL)querySupportNotLanguage:(NSString *)language_key{
    RLMResults<AppLanguageModel *> *langs = [AppLanguageModel objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([AppLanguageModel shareInstance].language_key),language_key]];
    
    return langs.firstObject;
}


#pragma mark - 打点相关接口

#pragma mark - app记录数据相关接口
/// 获取app记录数据
+(AppRecordModel *)queryAppRecordData{
    RLMResults<AppRecordModel *> *results = [AppRecordModel allObjects];
    if (results.firstObject) {
        return results.firstObject;
    } else {
        AppRecordModel *model = [AppRecordModel new];
        model.primaryKey = @"0000";
        
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] addOrUpdateObject:model];
        }];
        
        return model;
    }
}
/// 修改App设置参数
+(void)changeAppConfig:(NSDictionary *)parameters{
    NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [tmpDic setObject:@"0000" forKey:KK_VarNameToVar([AppRecordModel shareInstance].primaryKey)];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [AppRecordModel createOrUpdateInRealm:[RLMRealm defaultRealm] withValue:tmpDic];
    }];
}







#pragma mark - 自定义歌单接口
/// 添加默认歌单类型
+(void)addDefultMusicMenu{
    NSMutableArray<MusicListTypeModel *> *marr = [NSMutableArray new];
    {
        MusicListTypeModel *model = [MusicListTypeModel new];
        model.primaryKey = MusicListTypeDefultPrimaryKey;
        model.typeName = @"默认歌单";
        [marr addObject:model];
        {
            NSMutableArray <MusicListModel *> *listMarr = [NSMutableArray new];
            {
                MusicListModel *listModel = [MusicListModel new];
                listModel.primaryKey = MusicListCollectionPrimaryKey;
                listModel.listName = @"我的收藏";
                [listMarr addObject:listModel];
            }
            {
                MusicListModel *listModel = [MusicListModel new];
                listModel.primaryKey = MusicListRecentlyPlayedPrimaryKey;
                listModel.listName = @"最近播放";
                [listMarr addObject:listModel];
            }
            
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [model.musicListMarr addObjects:listMarr];
            }];
        }
    }
    {
        MusicListTypeModel *model = [MusicListTypeModel new];
        model.primaryKey = MusicListTypeSelfPrimaryKey;
        model.typeName = @"自建歌单";
        [marr addObject:model];
    }
    {
        MusicListTypeModel *model = [MusicListTypeModel new];
        model.primaryKey = MusicListTypeCollectionPrimaryKey;
        model.typeName = @"收藏歌单";
        [marr addObject:model];
    }
    {
        MusicListTypeModel *model = [MusicListTypeModel new];
        model.primaryKey = MusicListTypeRecentlyPlayedPrimaryKey;
        model.typeName = @"最近播放歌单";
        [marr addObject:model];
    }
    
        
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addOrUpdateObjects:marr];
    }];
}
/// 获取歌单数组
+(RLMArray<MusicListModel *><MusicListModel> *)queryMusicMenuList{
    MusicListTypeModel *listTypeSelf = [MusicListTypeModel objectForPrimaryKey:MusicListTypeSelfPrimaryKey];
    
    return listTypeSelf.musicListMarr;
}
/// 添加歌单
/// - Parameter model: 歌单数据
+(BOOL)addMusicMenu:(MusicListModel *)model{
    MusicListTypeModel *listTypeSelf = [MusicListTypeModel objectForPrimaryKey:MusicListTypeSelfPrimaryKey];
    
    RLMResults *haveResuts = [listTypeSelf.musicListMarr objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicListModel shareInstance].listName),model.listName]];
    if (haveResuts.firstObject) { // 歌单名子已存在
        return NO;
    } else {
        model.primaryKey = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,CFUUIDCreate(kCFAllocatorDefault)));
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [listTypeSelf.musicListMarr insertObject:model atIndex:0];
        }];
        return YES;
    }
}
/// 删除歌单
/// - Parameter primaryKey: 主键
+(BOOL)delMusicMenu:(NSString *)primaryKey{
    MusicListTypeModel *listTypeSelf = [MusicListTypeModel objectForPrimaryKey:MusicListTypeSelfPrimaryKey];
    
    NSInteger musicIndex = [listTypeSelf.musicListMarr indexOfObjectWhere:[NSString stringWithFormat:@"%@= '%@'",KK_VarNameToVar([MusicListModel shareInstance].primaryKey),primaryKey]];
    if (musicIndex != NSNotFound) {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [listTypeSelf.musicListMarr removeObjectAtIndex:musicIndex];
        }];
        
        return YES;
    }
    
    return NO;
}
/// 修改歌单名称
/// - Parameters:
///   - newName: 新名字
///   - primaryKey: 主键
+(void)changeMusicMenuName:(NSString *)newName primaryKey:(NSString *)primaryKey{
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [MusicListModel createOrUpdateInRealm:[RLMRealm defaultRealm] withValue:@{
            KK_VarNameToVar([MusicListModel shareInstance].primaryKey):primaryKey,
            KK_VarNameToVar([MusicListModel shareInstance].listName):newName,
        }];
    }];
}
/// 修改歌单排序
/// - Parameters:
///   - sourceIndex: 原始下标
///   - destinationIndex: 目的下标
+(void)changeMusicMenuOrderAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex{
    MusicListTypeModel *listTypeSelf = [MusicListTypeModel objectForPrimaryKey:MusicListTypeSelfPrimaryKey];
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [listTypeSelf.musicListMarr moveObjectAtIndex:sourceIndex toIndex:destinationIndex];
    }];
}
/// 添加歌曲到自定义歌单
/// - Parameter model: 歌曲数据
/// - Parameter primaryKey: 歌单逐渐
+(BOOL)addMusicToCustomizeMusicMenu:(MusicModel *)model primaryKey:(NSString *)primaryKey{
    MusicListModel *musicList = [MusicListModel objectForPrimaryKey:primaryKey];
    
    if ([musicList.musicMarr objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicModel shareInstance].primaryKey),model.primaryKey]].firstObject) {// 已存在
        return NO;
    } else {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] addOrUpdateObject:model];
        }];
        RLMResults *musicResults = [MusicModel objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicModel shareInstance].primaryKey),model.primaryKey]];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [musicList.musicMarr insertObject:musicResults.firstObject atIndex:0];
        }];
        
        return YES;
    }
}
/// 查询自定义歌单-歌曲
/// - Parameter primaryKey: 歌单逐渐
+(RLMArray<MusicModel *><MusicModel> *)queryCustomizeMusicMenuMusicList:(NSString *)primaryKey{
    MusicListModel *musicList = [MusicListModel objectForPrimaryKey:primaryKey];
    
    return musicList.musicMarr;
}
/// 删除歌曲-自定义歌单
/// - Parameter list_primaryKey: 歌单主键
/// - Parameter music_primaryKey: 歌曲主键
+(BOOL)delMusicToCustomizeMusicMenu:(NSString *)list_primaryKey music_primaryKey:(NSString *)music_primaryKey{
    MusicListModel *musicList = [MusicListModel objectForPrimaryKey:list_primaryKey];
    if (musicList) {
        NSInteger musicIndex = [musicList.musicMarr indexOfObjectWhere:[NSString stringWithFormat:@"%@= '%@'",KK_VarNameToVar([MusicListModel shareInstance].primaryKey),music_primaryKey]];
        if (musicIndex != NSNotFound) {
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [musicList.musicMarr removeObjectAtIndex:musicIndex];
            }];
            
            return YES;
        }
    }
    
    return NO;
}
/// 根据歌曲ID查询，歌曲是否在指定歌单里
/// - Parameter list_primaryKey: 歌单主键
/// - Parameter music_primaryKey: 歌曲主键
+(BOOL)queryMusicHaveMusicMenuByID:(NSString *)list_primaryKey music_primaryKey:(NSString *)music_primaryKey{
    MusicListModel *musicList = [MusicListModel objectForPrimaryKey:list_primaryKey];
    
    NSInteger musicIndex = [musicList.musicMarr indexOfObjectWhere:[NSString stringWithFormat:@"%@= '%@'",KK_VarNameToVar([MusicListModel shareInstance].primaryKey),music_primaryKey]];
    if (musicIndex == NSNotFound) {
        return NO;
    }else{
        return YES;
    }
}
/// 修改歌曲排序-自定义歌单
/// - Parameters:
///   - primaryKey: 歌单主键
///   - sourceIndex: 原始下标
///   - destinationIndex: 目的下标
+(void)changeCustomizeMusicOrder:(NSString *)primaryKey AtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex{
    MusicListModel *results = [MusicListModel objectForPrimaryKey:primaryKey];
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [results.musicMarr moveObjectAtIndex:sourceIndex toIndex:destinationIndex];
    }];
}



#pragma mark - 歌单收藏接口
/// 添加收藏歌单
/// - Parameter model: 歌单数据
+(BOOL)addNetWorkMusicMenu:(MusicListModel *)model{
    MusicListTypeModel *listTypeCollection = [MusicListTypeModel objectForPrimaryKey:MusicListTypeCollectionPrimaryKey];
    
    RLMResults *haveResuts = [listTypeCollection.musicListMarr objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicListModel shareInstance].primaryKey),model.primaryKey]];
    if (haveResuts.firstObject) { // 歌单已存在
        return NO;
    } else {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [listTypeCollection.musicListMarr insertObject:model atIndex:0];
        }];
        return YES;
    }
}
/// 查询收藏歌单
+(RLMArray<MusicListModel *><MusicListModel> *)queryNetWorkMusicMenu{
    MusicListTypeModel *listTypeCollection = [MusicListTypeModel objectForPrimaryKey:MusicListTypeCollectionPrimaryKey];
    
    return listTypeCollection.musicListMarr;
}
/// 查询-根据ID查询歌单是否收藏
/// - Parameter primaryKey: 主键
+(BOOL)queryMusicIsNetWorkMusicMenu:(NSString *)primaryKey{
    MusicListTypeModel *listTypeCollection = [MusicListTypeModel objectForPrimaryKey:MusicListTypeCollectionPrimaryKey];
    
    if ([listTypeCollection.musicListMarr objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",[MusicListModel shareInstance].primaryKey,primaryKey]].firstObject) {
        return YES;
    } else {
        return NO;
    }
}
/// 删除收藏歌单
/// - Parameter primaryKey: 主键
+(BOOL)delNetWorkMusicMenu:(NSString *)primaryKey{
    MusicListTypeModel *listTypeSelf = [MusicListTypeModel objectForPrimaryKey:MusicListTypeCollectionPrimaryKey];
    
    NSInteger musicIndex = [listTypeSelf.musicListMarr indexOfObjectWhere:[NSString stringWithFormat:@"%@= '%@'",KK_VarNameToVar([MusicListModel shareInstance].primaryKey),primaryKey]];
    if (musicIndex != NSNotFound) {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [listTypeSelf.musicListMarr removeObjectAtIndex:musicIndex];
        }];
        
        return YES;
    }
    
    return NO;
}
/// 修改歌单收藏排序
/// - Parameters:
///   - sourceIndex: 原始下标
///   - destinationIndex: 目的下标
+(void)changeNetWorkMusicMenuOrderAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex{
    MusicListTypeModel *listTypeSelf = [MusicListTypeModel objectForPrimaryKey:MusicListTypeCollectionPrimaryKey];
    
    [listTypeSelf.musicListMarr moveObjectAtIndex:sourceIndex toIndex:destinationIndex];
}




#pragma mark - 歌曲收藏接口
/// 添加收藏歌曲
/// - Parameter model: 歌曲数据
+(BOOL)addCollectMusic:(MusicModel *)model{
    MusicListModel *listCollection = [MusicListModel objectForPrimaryKey:MusicListCollectionPrimaryKey];
    
    if ([listCollection.musicMarr objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicModel shareInstance].primaryKey),model.primaryKey]].firstObject) {// 已存在
        return NO;
    } else {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] addOrUpdateObject:model];
        }];
        RLMResults *musicResults = [MusicModel objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicModel shareInstance].primaryKey),model.primaryKey]];
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [listCollection.musicMarr insertObject:musicResults.firstObject atIndex:0];
        }];
        
        return YES;
    }
    
    return NO;
}
/// 查询收藏歌曲
+(RLMArray<MusicModel *><MusicModel> *)queryCollectMusic{
    MusicListModel *listCollection = [MusicListModel objectForPrimaryKey:MusicListCollectionPrimaryKey];
    
    return listCollection.musicMarr;
}
/// 查询-根据ID查询歌曲是否收藏
/// - Parameter primaryKey: 主键
+(BOOL)queryMusicIsCollectMusic:(NSString *)primaryKey{
    MusicListModel *listCollection = [MusicListModel objectForPrimaryKey:MusicListCollectionPrimaryKey];

    if ([listCollection.musicMarr objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicModel shareInstance].primaryKey),primaryKey]].firstObject) {
        return YES;
    }
    
    return NO;
}
/// 删除收藏歌曲
/// - Parameter primaryKey: 主键
+(void)delCollectMusic:(NSString *)primaryKey{
    MusicListModel *listCollection = [MusicListModel objectForPrimaryKey:MusicListCollectionPrimaryKey];

    NSInteger musicIndex = [listCollection.musicMarr indexOfObjectWhere:[NSString stringWithFormat:@"%@= '%@'",KK_VarNameToVar([MusicModel shareInstance].primaryKey),primaryKey]];
    if (musicIndex != NSNotFound) {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [listCollection.musicMarr removeObjectAtIndex:musicIndex];
        }];
    }
}
/// 修改歌曲收藏排序
/// - Parameters:
///   - sourceIndex: 原始下标
///   - destinationIndex: 目的下标
+(void)changeCollectMusicOrderAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex{
    MusicListModel *listCollection = [MusicListModel objectForPrimaryKey:MusicListCollectionPrimaryKey];
        
    [listCollection.musicMarr moveObjectAtIndex:sourceIndex toIndex:destinationIndex];
}




#pragma mark - 最近播放接口
/// 添加最近播放歌曲
/// - Parameter model: 歌曲数据
+(BOOL)addRecentlyPlayed:(MusicModel *)model{
    MusicListModel *listCollection = [MusicListModel objectForPrimaryKey:MusicListRecentlyPlayedPrimaryKey];
    NSInteger musicIndex = [listCollection.musicMarr indexOfObjectWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicModel shareInstance].primaryKey),model.primaryKey]];
    if (musicIndex != NSNotFound) {// 已存在,先删除在添加
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [listCollection.musicMarr removeObjectAtIndex:musicIndex];
        }];
    }
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addOrUpdateObject:model];
    }];
    RLMResults *musicResults = [MusicModel objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicModel shareInstance].primaryKey),model.primaryKey]];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [listCollection.musicMarr insertObject:musicResults.firstObject atIndex:0];
    }];
    
    return YES;
}
/// 查询最近播放歌曲
+(RLMArray<MusicModel *><MusicModel> *)queryRecentlyPlayed{
    MusicListModel *listCollection = [MusicListModel objectForPrimaryKey:MusicListRecentlyPlayedPrimaryKey];

    return listCollection.musicMarr;
}
/// 添加最近播放歌单
/// - Parameter model: 歌单数据
+(BOOL)addRecentlyPlayedMenu:(MusicListModel *)model{
    MusicListTypeModel *listTypeRecentlyPlayed = [MusicListTypeModel objectForPrimaryKey:MusicListTypeRecentlyPlayedPrimaryKey];
    
    NSInteger musicIndex = [listTypeRecentlyPlayed.musicListMarr indexOfObjectWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicListModel shareInstance].primaryKey),model.primaryKey]];
    if (musicIndex != NSNotFound) {// 已存在,先删除在添加
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [listTypeRecentlyPlayed.musicListMarr removeObjectAtIndex:musicIndex];
        }];
    }
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addOrUpdateObject:model];
    }];
    RLMResults *musicResults = [MusicListModel objectsWhere:[NSString stringWithFormat:@"%@ = '%@'",KK_VarNameToVar([MusicListModel shareInstance].primaryKey),model.primaryKey]];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [listTypeRecentlyPlayed.musicListMarr insertObject:musicResults.firstObject atIndex:0];
    }];
    
    return YES;
}
/// 查询最近播放歌单
+(RLMArray<MusicListModel *><MusicListModel> *)aueryRecentlyPlayedMenu{
    MusicListTypeModel *listTypeRecentlyPlayed = [MusicListTypeModel objectForPrimaryKey:MusicListTypeRecentlyPlayedPrimaryKey];
    
    return listTypeRecentlyPlayed.musicListMarr;
}
/// 添加最近播放统计：用于App下次启动播放列表默认歌曲
+(void)addRecentlyPlayedToStartAppUser:(NSMutableDictionary *)parameters{
    
}
/// 获取最近播放统计：用于App下次启动播放列表默认歌曲
+(void)queryRecentlyPlayedToStartAppUser:(NSMutableDictionary *)parameters{
    
}
@end
