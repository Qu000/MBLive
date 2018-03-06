//
//  MBNetworkTool.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/6.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
};

@interface MBNetworkTool : AFHTTPSessionManager

+ (instancetype)shareTool;

// 判断网络类型
+ (NetworkStates)getNetworkStates;

@end
