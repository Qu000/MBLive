//
//  MBFollowVc.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/7.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBFollowVc.h"

@interface MBFollowVc ()

/** 背景图 */
@property(nonatomic, weak) UIImageView *bgImage;

@end

@implementation MBFollowVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self setupUI];
    
}

- (void)setupUI{
   
    [self setupImage];
    [self setupRemindLab];
}
/** 背景图片 */
- (void)setupImage{
    
    UIImageView * bgImage = [[UIImageView alloc]init];
    bgImage.image = [UIImage imageNamed:@"no_follow_250x247"];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@96);
        make.width.height.equalTo(@250);
        make.centerX.equalTo(self.view);
    }];
    [self.view addSubview:bgImage];
    self.bgImage = bgImage;
    
}
/** 提示信息 */
- (void)setupRemindLab{
    UILabel * remindLab = [[UILabel alloc]init];
    remindLab.text = @"你关注的主播还没有开播呐";
    remindLab.textColor = [UIColor whiteColor];
    remindLab.textAlignment = NSTextAlignmentCenter;
    remindLab.font = [UIFont systemFontOfSize:15];
    remindLab.backgroundColor = [UIColor clearColor];
    [remindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImage);
        make.left.right.equalTo(@30);
        make.height.equalTo(@22);
    }];
    [self.view addSubview:remindLab];
}
@end
