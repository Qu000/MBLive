//
//  MBSelectedView.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/6.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HomeType) {
    HomeTypeHot, // 热门
    HomeTypeNew, // 最新
    HomeTypeCare // 关注
};

@interface MBSelectedView : UIView

/** 选中了 */
@property(nonatomic, copy)void (^selectedBlock)(HomeType type);
/** 下划线 */
@property (nonatomic, weak, readonly)UIView *underLine;
/** 设置滑动选中的按钮 */
@property(nonatomic, assign) HomeType selectedType;

@end
