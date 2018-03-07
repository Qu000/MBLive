//
//  MBHomeViewController.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBHomeViewController.h"
#import "MBSelectedView.h"
#import "MBHotVc.h"

#import "MBWebVc.h"
@interface MBHomeViewController ()<UIScrollViewDelegate>
/** 顶部选择视图 */
@property(nonatomic, assign) MBSelectedView *selectedView;
/** UIScrollView */
@property(nonatomic, weak) UIScrollView *scrollView;
/** 热播 */
@property(nonatomic, weak) MBHotVc *hotVc;

@end

@implementation MBHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self setupUI];
}

- (void)setupUI{
    [self setupNav];
    [self setupScrollView];
}

- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:@selector(rankCrown)];
    [self setupTopMenu];
}
- (void)rankCrown{
    MBWebVc * webVc = [[MBWebVc alloc]initWithUrlStr:@"http://live.9158.com/Rank/WeekRank?Random=10"];
    webVc.navigationItem.title = @"排行";
    [_selectedView removeFromSuperview];
    _selectedView = nil;
    [self.navigationController pushViewController:webVc animated:YES];
}
- (void)setupTopMenu{
    //顶部选择
    MBSelectedView * selectedView = [[MBSelectedView alloc]initWithFrame:self.navigationController.navigationBar.bounds];
    selectedView.x = 45;
    selectedView.width = MBScreenWidth - 45*2;
    [selectedView setSelectedBlock:^(HomeType type) {
        [self.scrollView setContentOffset:CGPointMake(type*MBScreenWidth, 0) animated:YES];
    }];
    [self.navigationController.navigationBar addSubview:selectedView];
    _selectedView = selectedView;
}
- (void)setupScrollView{
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize = CGSizeMake(MBScreenWidth * 3, 0);
    scrollView.backgroundColor = [UIColor whiteColor];
    
    //去掉滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //设置分页
    scrollView.pagingEnabled = YES;
    //设置代理
    scrollView.delegate = self;
    //去掉弹簧效果
    scrollView.bounces = NO;
    
    CGFloat height = MBScreenHeight - 49;
    
    //添加子视图
    MBHotVc *hotVc = [[MBHotVc alloc]init];
    hotVc.view.frame = [UIScreen mainScreen].bounds;
    hotVc.view.height = height;
    [self addChildViewController:hotVc];
    [scrollView addSubview:hotVc.view];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
