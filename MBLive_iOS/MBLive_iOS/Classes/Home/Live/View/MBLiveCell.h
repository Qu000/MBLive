//
//  MBLiveCell.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBHomeLiveModel;//MBUser
@interface MBLiveCell : UICollectionViewCell
/** 直播*/
@property (nonatomic, strong) MBHomeLiveModel * live;
/** 相关直播或者主播*/
@property (nonatomic, strong) MBHomeLiveModel * relateLive;
/** 父控制器 */
@property (nonatomic, weak) UIViewController *parentVc;
/** 点击关联主播 */
@property (nonatomic, copy) void (^clickRelatedLive)();
@end
