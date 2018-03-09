//
//  MBLiveEndView.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/9.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBLiveEndView : UIView

+ (instancetype)liveEndView;
/** 查看其他主播 */
@property (nonatomic, copy) void (^lookOtherBlock)();
/** 退出 */
@property (nonatomic, copy) void (^quitBlock)();
@end
