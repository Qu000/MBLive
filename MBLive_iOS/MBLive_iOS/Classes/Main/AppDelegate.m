//
//  AppDelegate.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "AppDelegate.h"
#import "MBLoginViewController.h"
#import "MBTopWindow.h"
#import "Reachability.h"

@interface AppDelegate ()
{
    Reachability *_reacha;
    NetworkStates _preStatus;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[MBLoginViewController alloc] init];
    
    [self.window makeKeyAndVisible];

    [self checkNetworkStates];
    NSLog(@"网络状态码:----->%ld", [MBNetworkTool getNetworkStates]);
    return YES;
}
/** 实时监控网络状态 */
- (void)checkNetworkStates{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [_reacha startNotifier];
    
}

- (void)networkChange{
    NSString *reminds;
    NetworkStates currentStates = [MBNetworkTool getNetworkStates];
    if (currentStates == _preStatus) {
        return;
    }
    _preStatus = currentStates;
    switch (currentStates) {
        case NetworkStatesNone:
            reminds = @"当前无网络, 请检查您的网络状态";
            break;
        case NetworkStates2G:
            reminds = @"当前为2G网络";
            break;
        case NetworkStates3G:
            reminds = @"当前为3G网络";
            break;
        case NetworkStates4G:
            reminds = @"当前为4G网络";
            break;
        case NetworkStatesWIFI:
            reminds = nil;
            break;
        default:
            break;
    }
    
    if (reminds.length) {
        [[[UIAlertView alloc] initWithTitle:@"喵播" message:reminds delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

#pragma mark - 应用开始聚焦
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // 给状态栏添加一个按钮可以进行点击, 可以让屏幕上的scrollView滚到最顶部
    [MBTopWindow show];
}

@end
