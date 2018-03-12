//
//  MBLiveVc.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBLiveVc.h"
#import "MBLiveCell.h"
#import "MBLiveFlowLayout.h"
#import "MBRefresh.h"
#import "MBUserView.h"

#import "MBUser.h"
@interface MBLiveVc ()
/** 用户信息View */
@property(nonatomic, weak) MBUserView *userView;
@end

@implementation MBLiveVc

static NSString * const reuseIdentifier = @"MBLiveCell";

- (instancetype)init
{
    return [super initWithCollectionViewLayout:[[MBLiveFlowLayout alloc] init]];
}

-(MBUserView *)userView{
    if (!_userView) {
        MBUserView *userView = [MBUserView userView];
        [self.collectionView addSubview:userView];
        _userView = userView;
        
        [userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.width.equalTo(@(MBScreenWidth));
            make.height.equalTo(@(MBScreenHeight));
        }];
        
        userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [userView setCloseBlock:^{
            [UIView animateWithDuration:0.5 animations:^{
                self.userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                [self.userView removeFromSuperview];
                self.userView = nil;
            }];
        }];
    }
    return _userView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];}

- (void)setupUI{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MBLiveCell class] forCellWithReuseIdentifier:reuseIdentifier];
    MBRefresh *header = [MBRefresh headerWithRefreshingBlock:^{
        [self.collectionView.mj_header endRefreshing];
        self.currentIndex++;
        if (self.currentIndex == self.lives.count) {
            self.currentIndex = 0;
        }
        [self.collectionView reloadData];
    }];
    header.stateLabel.hidden = NO;
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStateIdle];
    self.collectionView.mj_header = header;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUser:) name:kNotifyClickUser object:nil];
}

- (void)clickUser:(NSNotification *)notification{
    if (notification.userInfo[@"user"] != nil) {
        MBUser *user = notification.userInfo[@"user"];
        self.userView.user = user;
        [UIView animateWithDuration:0.5 animations:^{
            self.userView.transform = CGAffineTransformIdentity;
        }];
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MBLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.parentVc = self;
    cell.live = self.lives[self.currentIndex];
    NSUInteger relateIndex = self.currentIndex;
    if (self.currentIndex + 1 == self.lives.count) {
        relateIndex = 0;
    }else {
        relateIndex += 1;
    }
    cell.relateLive = self.lives[relateIndex];
    [cell setClickRelatedLive:^{
        self.currentIndex += 1;
        [self.collectionView reloadData];
    }];
    return cell;
}

#pragma mark <UICollectionViewDelegate>



@end
