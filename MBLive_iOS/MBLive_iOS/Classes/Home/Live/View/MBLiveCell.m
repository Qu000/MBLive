//
//  MBLiveCell.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBLiveCell.h"
#import "MBBottomToolView.h"
#import <BarrageRenderer.h>
#import "MBCatEarView.h"

#import "MBHomeLiveModel.h"
#import "MBUser.h"
@interface MBLiveCell()
{
    /** 弹幕 */
    BarrageRenderer *_renderer;
    NSTimer * _timer;
}
/** 直播的播放器*/
@property (nonatomic, strong) IJKFFMoviePlayerController * moviePlayer;
/** 直播底部工具条 */
@property(nonatomic, weak) MBBottomToolView *toolView;
/** 同类型直播视图 */
@property(nonatomic, weak) MBCatEarView *catEarView;

/** 同一个工会的主播/相关主播 */
@property(nonatomic, weak) UIImageView *otherView;
/** 直播开始前的占位图片 */
@property(nonatomic, weak) UIImageView *placeHolderView;
/** 粒子动画 */
@property(nonatomic, weak) CAEmitterLayer *emitterLayer;
@end

@implementation MBLiveCell

#pragma  mark --- 懒加载
-(UIImageView *)placeHolderView{
    if (!_placeHolderView) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = self.contentView.bounds;
        imageV.image = [UIImage imageNamed:@"profile_user_414x414"];
        [self.contentView addSubview:imageV];
        _placeHolderView = imageV;
        [self.parentVc showGifLoding:nil inView:self.placeHolderView];
        
        // 强制布局
        [_placeHolderView layoutIfNeeded];
    }
    return _placeHolderView;
}

bool _isSelected = NO;
-(MBBottomToolView *)toolView{
    if (!_toolView) {
        MBBottomToolView * toolView = [[MBBottomToolView alloc]init];
        [toolView setClickToolBlock:^(LiveToolType type) {
            switch (type) {
                case LiveToolTypePublicTalk:
                    _isSelected = !_isSelected;
                    _isSelected ? [_renderer start] : [_renderer stop];
                    break;
                case LiveToolTypePrivateTalk:
                    
                    break;
                case LiveToolTypeGift:
                    
                    break;
                case LiveToolTypeRank:
                    
                    break;
                case LiveToolTypeShare:
                    
                    break;
                case LiveToolTypeClose:
//                    [self quit];
                    break;
                default:
                    break;
            }
        }];
        [self.contentView insertSubview:toolView aboveSubview:self.placeHolderView];
        [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@-10);
            make.height.equalTo(@40);
        }];
        _toolView = toolView;
    }
    return _toolView;
}
-(UIImageView *)otherView{
    if (!_otherView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"private_icon_70x70"]];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOther)]];
        [self.moviePlayer.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.catEarView);
            make.bottom.equalTo(self.catEarView.mas_top).offset(-40);
        }];
        _otherView = imageView;
    }
    return _otherView;
}








@end
