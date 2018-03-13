//
//  MBNewVc.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/7.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBNewVc.h"
#import "MBHomeLiveModel.h"
#import "MBUser.h"
#import "MBNewFlowLayout.h"
#import "MBRefresh.h"
#import "MBAnchorViewCell.h"

#import "MBLiveVc.h"

@interface MBNewVc ()
/** 最新主播列表 */
@property(nonatomic, strong) NSMutableArray *anchors;
/** 当前页 */
@property(nonatomic, assign) NSUInteger currentPage;
/** NSTimer */
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation MBNewVc

static NSString * const reuseIdentifier = @"MBAnchorViewCell";

- (NSMutableArray *)anchors
{
    if (!_anchors) {
        _anchors = [NSMutableArray array];
    }
    return _anchors;
}

- (instancetype)init
{
    return [super initWithCollectionViewLayout:[[MBNewFlowLayout alloc] init]];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 首先自动刷新一次
    [self autoRefresh];
    // 然后开启每一分钟自动更新
    _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(autoRefresh) userInfo:nil repeats:YES];
}
- (void)autoRefresh
{
    [self.collectionView.mj_header beginRefreshing];
    NSLog(@"刷新最新主播界面");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}

- (void)setupUI{
    // 默认当前页从1开始的
    self.currentPage = 1;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MBAnchorViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.mj_header = [MBRefresh headerWithRefreshingBlock:^{
        self.currentPage = 1;
        self.anchors = [NSMutableArray array];
        [self getAnchorsList];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getAnchorsList];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)getAnchorsList{
    [[MBNetworkTool shareTool] GET:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld",self.currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        NSString *state = responseObject[@"msg"];
        if ([state isEqualToString:@"fail"]) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            [self showHint:@"暂时没有更多最新数据"];
            self.currentPage--;
        }else {
            [responseObject[@"data"][@"list"] writeToFile:@"/Users/apple/Desktop/user.plist" atomically:YES];
            NSArray * result = [MBUser mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (result.count) {
                [self.anchors addObjectsFromArray:result];
                [self.collectionView reloadData];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.currentPage--;
        [self showHint:@"网络异常"];
    }];
}





#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.anchors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MBAnchorViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.user = self.anchors[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MBLiveVc * liveVc = [[MBLiveVc alloc]init];
    NSMutableArray * array = [NSMutableArray array];
    for (MBUser *user in self.anchors) {
        MBHomeLiveModel *live = [[MBHomeLiveModel alloc]init];
        live.bigpic = user.photo;
        live.myname = user.nickname;
        live.smallpic = user.photo;
        live.gps = user.position;
        live.useridx = user.useridx;
        live.allnum = arc4random_uniform(666);
        live.flv = user.flv;
        [array addObject:live];
    }
    liveVc.lives = array;
    liveVc.currentIndex = indexPath.item;
    [self presentViewController:liveVc animated:YES completion:nil];
}


@end
