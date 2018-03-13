//
//  MBFollowViewController.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBFollowViewController.h"

@interface MBFollowViewController ()
/** 背景图 */
@property(nonatomic, weak) UIImageView *bgImage;
/** 提示信息 */
@property(nonatomic, weak) UILabel *remindLab;
@end

@implementation MBFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self setupUI];
    
}

- (void)setupUI{
    
    [self setupImage];
    
}
/** 背景图片 */
- (void)setupImage{
    
    UIImageView * bgImage = [[UIImageView alloc]init];
    bgImage.image = [UIImage imageNamed:@"no_follow_250x247"];
    CGFloat WH = 250;
    CGFloat Y = 96;
    CGFloat X = (self.view.width - WH)/2;
    bgImage.frame = CGRectMake(X, Y, WH, WH);
    [self.view addSubview:bgImage];
    self.bgImage = bgImage;
  
    [self setupRemindLab];
    
}


/** 提示信息 */
- (void)setupRemindLab{
    UILabel * remindLab = [[UILabel alloc]init];
    remindLab.text = @"你关注的主播还没有开播呐";
    remindLab.textColor = KeyColor;
    remindLab.textAlignment = NSTextAlignmentCenter;
    remindLab.font = [UIFont systemFontOfSize:18];
    remindLab.backgroundColor = [UIColor clearColor];
    CGFloat M = 30;
    CGFloat W = self.view.width - 2*M;
    CGFloat Y = CGRectGetMaxY(self.bgImage.frame)+30;
    CGFloat H = 22;
    remindLab.frame = CGRectMake(M, Y, W, H);
    [self.view addSubview:remindLab];
    self.remindLab = remindLab;

    
    [self setupSeeBtn];
}
- (void)setupSeeBtn{
    UIButton * seeBtn = [[UIButton alloc]init];
    [seeBtn setTitle:@"去看看当前热门直播" forState:UIControlStateNormal];
    [seeBtn setTitleColor:KeyColor forState:UIControlStateNormal];
    //[UIColor colorWithRed:223 green:0 blue:104 alpha:0]
    seeBtn.backgroundColor = [UIColor clearColor];
    seeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [seeBtn addTarget:self action:@selector(clickSeeBtn) forControlEvents:UIControlEventTouchUpInside];
    seeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    CGFloat M = 30;
    CGFloat W = self.view.width - 2*M;
    CGFloat Y = CGRectGetMaxY(self.remindLab.frame)+30;
    CGFloat H = 22;
    seeBtn.frame = CGRectMake(M, Y, W, H);
    [self.view addSubview:seeBtn];
}
- (void)clickSeeBtn{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyToseeBigWorld object:nil];
}



@end
