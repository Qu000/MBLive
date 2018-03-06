//
//  MBHomeViewController.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBHomeViewController.h"
#import "MBSelectedView.h"

@interface MBHomeViewController ()
/** 顶部选择视图 */
@property(nonatomic, assign) MBSelectedView *selectedView;

@end

@implementation MBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
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
