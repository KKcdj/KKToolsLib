//
//  KKAudioPlayer.h
//  FileMusic
//  
//  Created by 陈德军 on 2024/1/24.
//  Copyright ©合肥维方科技有限公司. All rights reserved.
//  
//                      ____   ____      __
//                     / ___\ / _  \    / /
//                    / /    / / / /   / /
//                   / /___ / /_/ /?__/ /
//                  /_ -_-_/____,‘\____/
//
//  FreeStreamer中已经加入了开启后台持续播放任务、播放中断处理
    

#import <Foundation/Foundation.h>
#import <FreeStreamer/FSAudioStream.h>

NS_ASSUME_NONNULL_BEGIN

// 播放器播放状态
typedef NS_ENUM(NSUInteger, KKAudioPlayerState) {
    KKAudioPlayerStateLoading,          // 加载中
    KKAudioPlayerStateBuffering,        // 缓冲中
    KKAudioPlayerStatePlaying,          // 播放
    KKAudioPlayerStatePaused,           // 暂停
    KKAudioPlayerStateStoppedBy,        // 停止（用户切换歌曲时调用）
    KKAudioPlayerStateStopped,          // 停止（播放器主动发出：如播放被打断）
    KKAudioPlayerStateEnded,            // 结束（播放完成）
    KKAudioPlayerStateError             // 错误
};

// 播放器缓冲状态
typedef NS_ENUM(NSUInteger, KKAudioBufferState) {
    KKAudioBufferStateNone,
    KKAudioBufferStateBuffering,
    KKAudioBufferStateFinished
};

#define kPlayer [KKAudioPlayer sharedInstance]


@class KKAudioPlayer;

@protocol KKAudioPlayerDelegate<NSObject>

// 播放器状态改变
- (void)KKPlayer:(KKAudioPlayer *)player statusChanged:(KKAudioPlayerState)status;

// 播放时间（单位：毫秒)、总时间（单位：毫秒）、进度（播放时间 / 总时间）
- (void)KKPlayer:(KKAudioPlayer *)player currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime progress:(float)progress;

// 总时间（单位：毫秒）
- (void)KKPlayer:(KKAudioPlayer *)player totalTime:(NSTimeInterval)totalTime;

// 缓冲进度
- (void)KKPlayer:(KKAudioPlayer *)player bufferProgress:(float)bufferProgress;

@end



@interface KKAudioPlayer : NSObject
/**
 代理
 */
@property (nonatomic, weak) id<KKAudioPlayerDelegate> delegate;

/**
 播放地址（网络或本地）
 */
@property (nonatomic, copy) NSString *playUrlStr;

/**
 播放状态
 */
@property (nonatomic, assign) KKAudioPlayerState    playerState;

/**
 缓冲状态
 */
@property (nonatomic, assign) KKAudioBufferState    bufferState;

/**
 单例

 @return 播放器对象
 */
+ (instancetype)sharedInstance;

/**
 快进、快退

 @param progress 进度
 */
- (void)setPlayerProgress:(float)progress;

/**
 设置播放速率 0.5 - 2.0， 1.0是正常速率
 
 @param progress 速率
 */
- (void)setPlayerPlayRate:(float)playRate;

/**
 播放
 */
- (void)play;

/**
 从某个进度开始播放

 @param progress 进度
 */
- (void)playFromProgress:(float)progress;

/**
 暂停
 */
- (void)pause;

/**
 恢复（暂停后再次播放使用）
 */
- (void)resume;

/**
 停止
 */
- (void)stop;
@end

NS_ASSUME_NONNULL_END
