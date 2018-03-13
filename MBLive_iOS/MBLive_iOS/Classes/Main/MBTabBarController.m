//
//  MBTabBarController.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/3.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBTabBarController.h"
#import "MBNavigationController.h"
#import "MBHomeViewController.h"
#import "MBFollowViewController.h"
#import "MBLiveViewController.h"
#import "MBDiscoverViewController.h"
#import "MBProfileViewController.h"

#import "UIDevice+MBExtension.h"
#import <AVFoundation/AVFoundation.h>
@interface MBTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setupUI];
}

- (void)setupUI{
    [self addChildViewController:[[MBHomeViewController alloc]init]  imageNamed:@"toolbar_home" title:@"首页"];
    [self addChildViewController:[[MBFollowViewController alloc]init] imageNamed:@"toolbar_home" title:@"关注"];
    UIViewController *showLive = [[UIViewController alloc] init];
    showLive.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:showLive imageNamed:@"toolbar_live" title:nil];
    [self addChildViewController:[[MBDiscoverViewController alloc]init] imageNamed:@"toolbar_me" title:@"发现"];
    [self addChildViewController:[[MBProfileViewController alloc] init] imageNamed:@"toolbar_me" title:@"我的"];
}
- (void)addChildViewController:(UIViewController *)childController imageNamed:(NSString *)imageName title:(NSString *)title{
    //包裹一个自定义的导航栏
    MBNavigationController * nav = [[MBNavigationController alloc]initWithRootViewController:childController];
    
    if (![title isEqualToString:@"首页"]) {
        childController.navigationItem.title = title;
    }

    //设置tabBarItem的title
    childController.tabBarItem.title = title;

    //设置文字样式
    NSMutableDictionary *textAtts = [NSMutableDictionary dictionary];
    textAtts[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectTextAtts = [NSMutableDictionary dictionary];
    selectTextAtts[NSForegroundColorAttributeName] = [UIColor purpleColor];

    [childController.tabBarItem setTitleTextAttributes:textAtts forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:selectTextAtts forState:UIControlStateSelected];
    
    //设置tabBarItem的图标
    //声明：这张图片按照原来的样子显示出来，不要自动渲染成其他颜色（默认蓝色）
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel", imageName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:nav];
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count-3) {
        // 判断是否是模拟器
        if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
            [self showInfo:@"请用真机进行测试, 此模块不支持模拟器测试"];
            return NO;
        }
        
        // 判断是否有摄像头
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self showInfo:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"];
            return NO;
        }
        
        // 判断是否有摄像头权限
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            [self showInfo:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
            return NO;
        }
        
        // 开启麦克风权限
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    return YES;
                }
                else {
                    [self showInfo:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                    return NO;
                }
            }];
        }
        
        MBLiveViewController *showTimeVc = [UIStoryboard storyboardWithName:NSStringFromClass([MBLiveViewController class]) bundle:nil].instantiateInitialViewController;
        [self presentViewController:showTimeVc animated:YES completion:nil];
        return NO;
    }
    return YES;
}


@end
