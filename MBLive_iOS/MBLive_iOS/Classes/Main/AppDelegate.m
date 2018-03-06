//
//  AppDelegate.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "AppDelegate.h"
#import "MBLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MBLoginViewController alloc] init];
    
    [self.window makeKeyAndVisible];
//
//    [self checkNetworkStates];
//    NSLog(@"网络状态码:----->%ld", [MBNetworkTool getNetworkStates]);
    return YES;
}
/** 实时监控网络状态 */



#pragma mark - 应用开始聚焦


@end
