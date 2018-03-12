//
//  MBUserView.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBUser;
@interface MBUserView : UIView
+ (instancetype)userView;
/** 点击关闭 */
@property (nonatomic, copy) void (^closeBlock)(void);
/** 用户信息 */
@property (nonatomic, strong) MBUser *user;
@end
