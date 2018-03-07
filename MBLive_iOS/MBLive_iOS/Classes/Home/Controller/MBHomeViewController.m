//
//  MBHomeViewController.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBHomeViewController.h"
#import "MBSelectedView.h"
#import "JHMainTopView.h"
#import "MBHotVc.h"
#import "MBNewVc.h"
#import "MBFollowVc.h"

#import "MBWebVc.h"
@interface MBHomeViewController ()<UIScrollViewDelegate>
/** 顶部选择视图 */
@property(nonatomic, assign) MBSelectedView *selectedView;
/** UIScrollView */
@property(nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray * dataList;

@property (nonatomic, strong) JHMainTopView * topView;
/** 热播 */
@property(nonatomic, weak) MBHotVc *hotVc;
/** 最新主播 */
@property(nonatomic, weak) MBNewVc *nowVc;
/** 关注主播 */
@property(nonatomic, weak) MBFollowVc *followVc;

@end

@implementation MBHomeViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_selectedView) {
        [self setupTopMenu];
    }
}
 

- (void)loadView{
    
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
    _hotVc = hotVc;
    
    MBNewVc *nowVc = [[MBNewVc alloc]init];
    nowVc.view.frame = [UIScreen mainScreen].bounds;
    nowVc.view.x = MBScreenWidth;
    nowVc.view.height = height;
    [self addChildViewController:nowVc];
    [scrollView addSubview:nowVc.view];
    _nowVc = nowVc;
    
    MBFollowVc *followVc = [[MBFollowVc alloc]init];
    followVc.view.frame = [UIScreen mainScreen].bounds;
    followVc.view.x = MBScreenWidth * 2;
    followVc.view.height = height;
    [self addChildViewController:followVc];
    [scrollView addSubview:followVc.view];
    _followVc = followVc;
    
    self.view = scrollView;
    self.scrollView = scrollView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
}


- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:nil];//@selector(rankCrown)
    self.navigationItem.titleView = self.topView;
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / MBScreenWidth;
    CGFloat offsetX = scrollView.contentOffset.x / MBScreenWidth * (self.selectedView.width * 0.5 - Home_Seleted_Item_W * 0.5 - 15);
    self.selectedView.underLine.x = 15 + offsetX;
    if (page == 1 ) {
        self.selectedView.underLine.x = offsetX + 10;
    }else if (page > 1){
        self.selectedView.underLine.x = offsetX + 5;
    }
    self.selectedView.selectedType = (int)(page + 0.5);
}

/*
 
 -(UIScrollView *)scrollView{
 if (!_scrollView) {
 _scrollView = [[UIScrollView alloc]init];
 [self.view addSubview:_scrollView];
 }
 return _scrollView;
 }
 -(JHMainTopView *)topView{
 if (!_topView) {
 _topView = [[JHMainTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.dataList];
 
 @weakify(self);
 _topView.block = ^(NSInteger tag) {
 @strongify(self);
 CGPoint point = CGPointMake(tag * MBScreenWidth, self.scrollView.contentOffset.y);
 [self.scrollView setContentOffset:point animated:YES];
 
 };
 }
 return _topView;
 }
 
 -(NSArray *)dataList{
 if (!_dataList) {
 _dataList = @[@"最热",@"最新",@"关注"];
 }
 return _dataList;
 }

 
 #pragma mark---添加子视图控制器
 - (void)setupChildViewControllers{
 NSArray * vcNames= @[@"MBHotVc",@"MBNewVc",@"MBFollowVc"];
 for (NSInteger i = 0; i < vcNames.count; i++) {
 NSString * vcName = vcNames[i];
 UIViewController * vc = [[NSClassFromString(vcName)alloc]init];
 vc.title = self.dataList[i];
 
 //addChildViewController:vc 不会执行该vc的viewDidLoad
 [self addChildViewController:vc];
 }
 
 //将子控制器的view加到MainVc的scrollView上
 
 //设置scrollView的contentSize
 self.scrollView.contentSize = CGSizeMake(MBScreenWidth*self.dataList.count, 0);
 
 self.scrollView.delegate = self;
 
 //默认先展示第二个界面
 self.scrollView.contentOffset = CGPointMake(MBScreenWidth, 0);
 
 //进入主控制器时加载页面
 [self scrollViewDidEndScrollingAnimation:self.scrollView];
 }
 
 #pragma mark---UIScrollViewDelegate
 //减速结束时调用。加载子控制器view
 -(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 CGFloat width = MBScreenWidth;
 CGFloat height = MBScreenHeight;
 CGFloat offset = scrollView.contentOffset.x;
 
 //获取第几个  的索引值
 NSInteger idx = offset / width;
 
 //传递联动索引值给topView
 [self.topView scrolling:idx];
 
 //根据索引值，返回vc的引用
 UIViewController * vc = self.childViewControllers[idx];
 
 //判读当前vc是否执行过viewDidLoad
 if ([vc isViewLoaded]) return;
 
 //设置子控制器view的大小
 vc.view.frame = CGRectMake(offset, 0, width, height);
 
 //将子控制器view加入到scrollView上
 [scrollView addSubview:vc.view];
 }
 
 //动画结束时调用(点击topView的button时，走的代理;因为topView中button的改变，不会走scrollViewDidEndDecelerating)
 -(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
 
 [self scrollViewDidEndDecelerating:scrollView];
 }
 */

@end
