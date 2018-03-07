//
//  MBHotVc.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/6.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBHotVc.h"
#import "MBHotCell.h"
#import "MBHotADCell.h"
#import "MBRefresh.h"
#import "MBWebVc.h"

#import "MBHomeLiveModel.h"
#import "MBHotADModel.h"
@interface MBHotVc ()
/** 当前页码数 */
@property(nonatomic, assign) NSUInteger currentPage;
/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;
/** 广告 */
@property(nonatomic, strong) NSArray *topADS;
@end

static NSString *reuseIdentifier = @"MBHotCell";
static NSString *ADReuseIdentifier = @"MBHotADCell";
@implementation MBHotVc


- (NSMutableArray *)lives
{
    if (!_lives) {
        _lives = [NSMutableArray array];
    }
    return _lives;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self setupUI];
}

- (void)setupUI{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MBHotCell class]) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerClass:[MBHotADCell class] forCellReuseIdentifier:ADReuseIdentifier];
    
    self.currentPage = 1;
    self.tableView.mj_header = [MBRefresh headerWithRefreshingBlock:^{
        self.lives = [NSMutableArray array];
        self.currentPage = 1;
        
        [self getTopAD];
        [self getHotLiveList];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getHotLiveList];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)getTopAD{
    [[MBNetworkTool shareTool] GET:@"http://live.9158.com/Living/GetAD" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * result = responseObject[@"data"];
        if ([self isNotEmpty:result]) {
            self.topADS = [MBHotADModel mj_objectArrayWithKeyValuesArray:result];
            [self.tableView reloadData];
        }else {
            [self showHint:@"网络异常"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"网络异常"];
    }];
}
- (void)getHotLiveList{
    [[MBNetworkTool shareTool] GET:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld",self.currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSArray * result = [MBHomeLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if ([self isNotEmpty:result]) {
            [self.lives addObjectsFromArray:result];
            [self.tableView reloadData];
        }else {
            [self showHint:@"暂时没有更多最新数据"];
            // 恢复当前页
            self.currentPage--;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.currentPage--;
        [self showHint:@"网络异常"];
    }];
}


#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.lives.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }
    return 465;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MBHotADCell * cell = [tableView dequeueReusableCellWithIdentifier:ADReuseIdentifier];
        if (self.topADS.count) {
            cell.topADs = self.topADS;
            [cell setImageClickBlock:^(MBHotADModel *topAD) {
                if (topAD.link.length) {
                    MBWebVc * webVc = [[MBWebVc alloc]initWithUrlStr:topAD.link];
                    webVc.navigationItem.title = topAD.title;
                    [self.navigationController pushViewController:webVc animated:YES];
                }
            }];
        }
        return cell;
    }
    
    
    MBHotCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (self.lives.count) {
        MBHomeLiveModel * live = self.lives[indexPath.row-1];
        cell.model = live;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
