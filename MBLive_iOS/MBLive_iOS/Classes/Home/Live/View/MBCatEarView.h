//
//  MBCatEarView.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/9.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBHomeLiveModel;
@interface MBCatEarView : UIView
/** 主播/主播 */
@property(nonatomic, strong) MBHomeLiveModel *live;
+ (instancetype)catEarView;
@end
