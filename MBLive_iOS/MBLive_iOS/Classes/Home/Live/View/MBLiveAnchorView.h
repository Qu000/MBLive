//
//  MBLiveAnchorView.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/9.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBUser;
@class MBHomeLiveModel;

@interface MBLiveAnchorView : UIView

+ (instancetype)liveAnchorView;
/** 主播*/
@property (nonatomic, strong) MBUser * user;
/** 直播*/
@property (nonatomic, strong) MBHomeLiveModel * live;
/** 点击开关  */
@property(nonatomic, copy)void (^clickDeviceShow)(bool selected);
@end
