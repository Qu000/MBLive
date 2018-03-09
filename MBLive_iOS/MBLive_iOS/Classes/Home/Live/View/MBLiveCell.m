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
#import "MBLiveAnchorView.h"

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
/** 顶部主播视图 */
@property(nonatomic, weak) MBLiveAnchorView *anchorView;

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

-(MBLiveAnchorView *)anchorView{
    if (!_anchorView) {
        MBLiveAnchorView * anchorView = [MBLiveAnchorView liveAnchorView];
        [anchorView setClickDeviceShow:^(bool selected) {
            if (_moviePlayer) {
                _moviePlayer.shouldShowHudView = !selected;
            }
        }];
        
        [self.contentView insertSubview:anchorView aboveSubview:self.placeHolderView];
        [anchorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@120);
            make.top.equalTo(@0);
        }];
        _anchorView = anchorView;
    }
    return _anchorView;
}

-(MBCatEarView *)catEarView{
    if (!_catEarView) {
        MBCatEarView * catEarView = [MBCatEarView catEarView];
        [self.moviePlayer.view addSubview:catEarView];
        [catEarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCatEar)]];
        [catEarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-30);
            make.centerY.equalTo(self.moviePlayer.view);
            make.width.height.equalTo(@98);
        }];
        _catEarView = catEarView;
    }
    return _catEarView;
}

-(CAEmitterLayer *)emitterLayer{
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        // 发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.frame.size.width-50,self.moviePlayer.view.frame.size.height-50);
        // 发射器的尺寸大小
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        // 开启三维效果
        //    _emitterLayer.preservesDepth = YES;
        NSMutableArray *array = [NSMutableArray array];
        // 创建粒子
        for (int i = 0; i<10; i++) {
            // 发射单元
            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
            // 粒子的创建速率，默认为1/s
            stepCell.birthRate = 1;
            // 粒子存活时间
            stepCell.lifetime = arc4random_uniform(4) + 1;
            // 粒子的生存时间容差
            stepCell.lifetimeRange = 1.5;
            // 颜色
            // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
            // 粒子显示的内容
            stepCell.contents = (id)[image CGImage];
            // 粒子的名字
            //            [fire setName:@"step%d", i];
            // 粒子的运动速度
            stepCell.velocity = arc4random_uniform(100) + 100;
            // 粒子速度的容差
            stepCell.velocityRange = 80;
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude = M_PI+M_PI_2;;
            // 粒子发射角度的容差
            stepCell.emissionRange = M_PI_2/6;
            // 缩放比例
            stepCell.scale = 0.3;
            [array addObject:stepCell];
        }
        
        emitterLayer.emitterCells = array;
        [self.moviePlayer.view.layer insertSublayer:emitterLayer below:self.catEarView.layer];
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}





@end
