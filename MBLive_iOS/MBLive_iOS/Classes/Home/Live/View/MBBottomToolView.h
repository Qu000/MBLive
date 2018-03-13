//
//  MBBottomToolView.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LiveToolType) {
    ///弹幕
    LiveToolTypePublicTalk,
    ///私聊
    LiveToolTypePrivateTalk,
    ///礼物
    LiveToolTypeGift,
    ///打赏排行榜
    LiveToolTypeRank,
    ///分享
    LiveToolTypeShare,
    ///关闭-退出直播间
    LiveToolTypeClose
};

@interface MBBottomToolView : UIView
/** 点击工具栏  */
@property(nonatomic, copy)void (^clickToolBlock)(LiveToolType type);
@end
