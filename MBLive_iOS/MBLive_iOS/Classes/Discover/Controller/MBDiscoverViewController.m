//
//  MBDiscoverViewController.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/14.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBDiscoverViewController.h"
#import "MBHotCell.h"
#import "MBHomeLiveModel.h"
#import "MBLiveVc.h"

static NSString *reuseIdentifier = @"MBHotCell";

@interface MBDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>
/** TableView */
@property(nonatomic, weak) UITableView *tableView;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray * dataList;
@end

@implementation MBDiscoverViewController

#warning waite........
- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];

}

- (void)setupUI{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MBHotCell class]) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)loadData{
    MBHomeLiveModel * live = [[MBHomeLiveModel alloc]init];
    live.smallpic = @"";
    live.myname = @"福尔摩洪";
    live.gps = @"在重庆";
    live.bigpic = @"";
//    live.starlevel = ;
//    live.starImage ;
    live.allnum = 6666;
    live.flv = @"";
    [self.dataList addObject:live];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    JHLiveCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"JHLiveCell" owner:self options:nil] lastObject];
    
    MBHotCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    cell.model = self.dataList[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 465 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    MBHomeLiveModel * live = self.dataList[indexPath.row];
    
    MBLiveVc * playerVc = [[MBLiveVc alloc]init];
    playerVc.lives = self.dataList;//传值
    
    [self.navigationController pushViewController:playerVc animated:YES];
    
}

@end
