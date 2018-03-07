//
//  MBAnchorViewCell.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/7.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBAnchorViewCell.h"
#import "MBUser.h"

@interface MBAnchorViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *CoverView;
@property (weak, nonatomic) IBOutlet UIImageView *Star;
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLab;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@end
@implementation MBAnchorViewCell

-(void)setUser:(MBUser *)user{
    _user = user;
    // 设置封面头像
    [_CoverView sd_setImageWithURL:[NSURL URLWithString:user.photo] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    // 是否是新主播
    self.Star.hidden = !user.newStar;
    // 地址
    [self.locationBtn setTitle:user.position forState:UIControlStateNormal];
    // 主播名
    self.nikeNameLab.text = user.nickname;
}









- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
