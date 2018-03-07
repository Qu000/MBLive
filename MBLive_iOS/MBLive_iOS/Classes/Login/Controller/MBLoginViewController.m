//
//  MBLoginViewController.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/3.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBLoginViewController.h"
#import "MBTabBarController.h"
#import "MBThirdLogin.h"
@interface MBLoginViewController ()

/** player */
@property (nonatomic, strong) IJKFFMoviePlayerController *player;
/** 三方登录 */
@property (nonatomic, weak) MBThirdLogin * thirdLogin;
/** 快速登录 */
@property (nonatomic, weak) UIButton *quickBtn;
/** 封面图片 */
@property (nonatomic, weak) UIImageView *coverView;

@end

@implementation MBLoginViewController

-(IJKFFMoviePlayerController *)player
{
    if (!_player) {
        NSString * path = arc4random_uniform(10) % 2 ? @"login_video" : @"loginvideo";
        IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:[[NSBundle mainBundle] pathForResource:path ofType:@"mp4"] withOptions:[IJKFFOptions optionsByDefault]];
        player.view.frame = self.view.bounds;
        // 填充fill
        player.scalingMode = IJKMPMovieScalingModeAspectFill;
        [self.view addSubview:player.view];
        // 设置自动播放
        player.shouldAutoplay = NO;
        // 准备播放
        [player prepareToPlay];
        
        _player = player;
    }
    return _player;
}

-(MBThirdLogin *)thirdLogin{
    if (!_thirdLogin) {
        MBThirdLogin * thirdLogin = [[MBThirdLogin alloc]initWithFrame:CGRectMake(0, 0, 400, 200)];
        [thirdLogin setClickLogin:^(LoginType type) {
            [self loginSuccess];
        }];
        thirdLogin.hidden = YES;
        [self.view addSubview:thirdLogin];
        _thirdLogin = thirdLogin;
    }
    return _thirdLogin;
}
 
-(UIButton *)quickBtn{
    if (!_quickBtn) {
        UIButton * btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor redColor].CGColor;
        [btn setTitle:@"快速登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor yellowColor]  forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loginSuccess) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.hidden = YES;
        _quickBtn = btn;
    }
    return _quickBtn;
}

- (UIImageView *)coverView
{
    if (!_coverView) {
        UIImageView *cover = [[UIImageView alloc] initWithFrame:self.view.bounds];
        cover.image = [UIImage imageNamed:@"LaunchImage"];//login
        [self.player.view addSubview:cover];
        _coverView = cover;
    }
    return _coverView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.player shutdown];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.player.view removeFromSuperview];
    self.player = nil;
    
}


-(void)setupUI{
    [self initObserver];
    
    self.coverView.hidden = NO;
    
    [self.quickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.bottom.equalTo(@-150);
        make.height.equalTo(@40);
    }];
    
    [self.thirdLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@60);
        make.bottom.equalTo(self.quickBtn.mas_top).offset(-40);
    }];
     
    
}

#pragma mark - private method

- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}

- (void)stateDidChange
{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            self.coverView.frame = self.view.bounds;
            [self.view insertSubview:self.coverView atIndex:0];
            [self.player play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.thirdLogin.hidden = NO;
                self.quickBtn.hidden = NO;
            });
        }
    }
}
- (void)didFinish
{
    // 播放完之后, 继续重播
    [self.player play];
}


-(void)loginSuccess{
    [self showHint:@"登录成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:[[MBTabBarController alloc] init] animated:NO completion:^{
            [self.player stop];
            [self.player.view removeFromSuperview];
            self.player = nil;
        }];
    });
}


- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}


@end
