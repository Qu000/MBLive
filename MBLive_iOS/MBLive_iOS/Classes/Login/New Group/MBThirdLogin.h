//
//  MBThirdLogin.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/6.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeSina,
    LoginTypeQQ,
    LoginTypeWechat
};
@interface MBThirdLogin : UIView
/** 三方登录按钮 */
@property (nonatomic, copy) void (^clickLogin)(LoginType type);
@end
