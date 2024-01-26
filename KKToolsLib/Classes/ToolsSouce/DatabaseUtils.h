//
//  DatabaseUtils.h
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

//add
//del
//change
//query

#import <Foundation/Foundation.h>
#import "MusicModel.h"
#import "MusicListModel.h"


NS_ASSUME_NONNULL_BEGIN


@class AppRecordModel;

@interface DatabaseUtils : NSObject
#pragma mark - app多语言接口
/// 获取多语言数组
+(RLMResults *)queryMultilingualData;
/// 更新使用的语言
/// - Parameter primaryKey: 主健
+(BOOL)changeCurrentUserMultilingual:(NSString *)primaryKey;
/// 获取当前使用的语言
+(RLMResults *)queryCurrentUserMultilingual;
/// 查询是否支持此语言
/// - Parameter language_key: 语言代码
+(BOOL)querySupportNotLanguage:(NSString *)language_key;




#pragma mark - 打点相关接口



#pragma mark - app记录数据相关接口
/// 获取app记录数据
+(AppRecordModel *)queryAppRecordData;
/// 修改App设置参数
+(void)changeAppConfig:(NSDictionary *)parameters;



#pragma mark - 内购相关接口



#pragma mark - 自定义歌单接口
/// 添加默认歌单类型
+(void)addDefultMusicMenu;
/// 获取歌单数组
+(RLMArray<MusicListModel *><MusicListModel> *)queryMusicMenuList;
/// 添加歌单
/// - Parameter model: 歌单数据
+(BOOL)addMusicMenu:(MusicListModel *)model;
/// 删除歌单
/// - Parameter primaryKey: 主键
+(BOOL)delMusicMenu:(NSString *)primaryKey;
/// 修改歌单名称
/// - Parameters:
///   - newName: 新名字
///   - primaryKey: 主键
+(void)changeMusicMenuName:(NSString *)newName primaryKey:(NSString *)primaryKey;
/// 修改歌单排序
/// - Parameters:
///   - sourceIndex: 原始下标
///   - destinationIndex: 目的下标
+(void)changeMusicMenuOrderAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex;
/// 添加歌曲到自定义歌单
/// - Parameter model: 歌曲数据
/// - Parameter primaryKey: 歌单逐渐
+(BOOL)addMusicToCustomizeMusicMenu:(MusicModel *)model primaryKey:(NSString *)primaryKey;
/// 查询自定义歌单-歌曲
/// - Parameter primaryKey: 歌单逐渐
+(RLMArray<MusicModel *><MusicModel> *)queryCustomizeMusicMenuMusicList:(NSString *)primaryKey;
/// 删除歌曲-自定义歌单
/// - Parameter list_primaryKey: 歌单主键
/// - Parameter music_primaryKey: 歌曲主键
+(BOOL)delMusicToCustomizeMusicMenu:(NSString *)list_primaryKey music_primaryKey:(NSString *)music_primaryKey;
/// 根据歌曲ID查询，歌曲是否在指定歌单里
/// - Parameter list_primaryKey: 歌单主键
/// - Parameter music_primaryKey: 歌曲主键
+(BOOL)queryMusicHaveMusicMenuByID:(NSString *)list_primaryKey music_primaryKey:(NSString *)music_primaryKey;
/// 修改歌曲排序-自定义歌单
/// - Parameters:
///   - primaryKey: 歌单主键
///   - sourceIndex: 原始下标
///   - destinationIndex: 目的下标
+(void)changeCustomizeMusicOrder:(NSString *)primaryKey AtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex;



#pragma mark - 歌单收藏接口
/// 添加收藏歌单
/// - Parameter model: 歌单数据
+(BOOL)addNetWorkMusicMenu:(MusicListModel *)model;
/// 查询收藏歌单
+(RLMArray<MusicListModel *><MusicListModel> *)queryNetWorkMusicMenu;
/// 查询-根据ID查询歌单是否收藏
/// - Parameter primaryKey: 主键
+(BOOL)queryMusicIsNetWorkMusicMenu:(NSString *)primaryKey;
/// 删除收藏歌单
/// - Parameter primaryKey: 主键
+(BOOL)delNetWorkMusicMenu:(NSString *)primaryKey;
/// 修改歌单收藏排序
/// - Parameters:
///   - sourceIndex: 原始下标
///   - destinationIndex: 目的下标
+(void)changeNetWorkMusicMenuOrderAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex;


#pragma mark - 歌曲收藏接口
/// 添加收藏歌曲
/// - Parameter model: 歌曲数据
+(BOOL)addCollectMusic:(MusicModel *)model;
/// 查询收藏歌曲
+(RLMArray<MusicModel *><MusicModel> *)queryCollectMusic;
/// 查询-根据ID查询歌曲是否收藏
/// - Parameter primaryKey: 主键
+(BOOL)queryMusicIsCollectMusic:(NSString *)primaryKey;
/// 删除收藏歌曲
/// - Parameter primaryKey: 主键
+(void)delCollectMusic:(NSString *)primaryKey;
/// 修改歌曲收藏排序
/// - Parameters:
///   - sourceIndex: 原始下标
///   - destinationIndex: 目的下标
+(void)changeCollectMusicOrderAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex;


#pragma mark - 最近播放接口
/// 添加最近播放歌曲
/// - Parameter model: 歌曲数据
+(BOOL)addRecentlyPlayed:(MusicModel *)model;
/// 查询最近播放歌曲
+(RLMArray<MusicModel *><MusicModel> *)queryRecentlyPlayed;
/// 添加最近播放歌单
/// - Parameter model: 歌单数据
+(BOOL)addRecentlyPlayedMenu:(MusicListModel *)model;
/// 查询最近播放歌单
+(RLMArray<MusicListModel *><MusicListModel> *)aueryRecentlyPlayedMenu;
/// 添加最近播放统计：用于App下次启动播放列表默认歌曲
+(void)addRecentlyPlayedToStartAppUser:(NSMutableDictionary *)parameters;
/// 获取最近播放统计：用于App下次启动播放列表默认歌曲
+(void)queryRecentlyPlayedToStartAppUser:(NSMutableDictionary *)parameters;


#pragma mark - 搜索接口
/// 添加历史搜索记录
+(void)addSearchRecord:(NSMutableDictionary *)parameters;
/// 查询历史搜索记录
+(RLMResults *)querySearchRecord:(NSMutableDictionary *)parameters;
/// 删除历史搜索记录
+(void)delSearchRecord:(NSMutableDictionary *)parameters;
/// 删除所有历史搜索记录
+(void)delAllSearchRecord:(NSMutableDictionary *)parameters;



//#pragma mark - 我的下载接口
///// 添加我的下载歌曲
//+(void)addMyDownloadMusic:(NSMutableDictionary *)parameters;
///// 查询我的下载歌曲
//+(RLMResults *)queryMyDownloadMusic:(NSMutableDictionary *)parameters;
///// 查询我的下载歌曲--已下载
//+(RLMResults *)queryMyDownloadMusicDownloaded:(NSMutableDictionary *)parameters;
///// 根据ID查询歌曲是否正在下载
//+(BOOL)queryMyDownloadWithIDMusicDownloading:(NSMutableDictionary *)parameters;
///// 根据ID查询歌曲是否已经下载
//+(BOOL)queryMyDownloadWithIDMusicDownloaded:(NSMutableDictionary *)parameters;
///// 查询我的下载歌曲--正在下载
//+(RLMResults *)queryMyDownloadMusicDownloading:(NSMutableDictionary *)parameters;
///// 修改所有歌单中歌曲-状态改成已下载
//+(void)changeMyDownloadMusicDownloaded:(NSMutableDictionary *)parameters;
///// 删除我的下载歌曲
//+(void)delMyDownloadMusic:(NSMutableDictionary *)parameters;






@end

NS_ASSUME_NONNULL_END
