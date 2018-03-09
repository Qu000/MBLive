//
//  MBLiveAnchorView.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/9.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBLiveAnchorView.h"
#import "MBHomeLiveModel.h"
#import "MBUser.h"

@interface MBLiveAnchorView()

@property (weak, nonatomic) IBOutlet UIView *anchorView;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *peopleLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UIButton *giftBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSArray *chaoYangUsers;
@end
@implementation MBLiveAnchorView

-(NSArray *)chaoYangUsers{
    if (!_chaoYangUsers) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"user.plist" ofType:nil]];
        _chaoYangUsers = [MBUser mj_objectArrayWithKeyValuesArray:array];
    }
    return _chaoYangUsers;
}

+(instancetype)liveAnchorView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self maskViewToBounds:self.anchorView];
    [self maskViewToBounds:self.headIcon];
    [self maskViewToBounds:self.closeBtn];
    [self maskViewToBounds:self.giftBtn];
    
    self.headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headIcon.layer.borderWidth = 1;
    
    [self.closeBtn setBackgroundImage:[UIImage imageWithColor:KeyColor size:self.closeBtn.size] forState:UIControlStateNormal];
    [self.closeBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:self.closeBtn.size] forState:UIControlStateSelected];

    [self setupChaoyang];
    // 默认是关闭的
    [self clickClose:self.closeBtn];
}
- (void)maskViewToBounds:(UIView *)view
{
    view.layer.cornerRadius = view.height * 0.5;
    view.layer.masksToBounds = YES;
}

static int randomNum = 0;
-(void)setLive:(MBHomeLiveModel *)live{
    _live = live;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:live.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    self.nameLab.text = live.myname;
    self.peopleLab.text = [NSString stringWithFormat:@"%ld人",live.allnum];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateNum) userInfo:nil repeats:YES];
    self.headIcon.userInteractionEnabled = YES;
    [self.headIcon addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickChaoYang:)]];
}
- (void)updateNum{
    randomNum += arc4random_uniform(5);
    self.peopleLab.text = [NSString stringWithFormat:@"%ld人",self.live.allnum + randomNum];
    [self.giftBtn setTitle:[NSString stringWithFormat:@"猫粮:%u  娃娃%u", 6666 + randomNum,  666+randomNum] forState:UIControlStateNormal];
}

- (void)clickChaoYang:(UITapGestureRecognizer *)tapGes
{
    if (tapGes.view == self.headIcon) {
        MBUser *user = [[MBUser alloc] init];
        user.nickname = self.live.myname;
        user.photo = self.live.bigpic;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : user}];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : self.chaoYangUsers[tapGes.view.tag]}];
    }
    
}

- (void)setupChaoyang
{
    self.scrollView.contentSize = CGSizeMake((self.scrollView.height + DefaultMargin) * self.chaoYangUsers.count + DefaultMargin, 0);
    CGFloat width = self.scrollView.height - 10;
    CGFloat x = 0;
    for (int i = 0; i<self.chaoYangUsers.count; i++) {
        x = 0 + (DefaultMargin + width) * i;
        UIImageView *userView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 5, width, width)];
        userView.layer.cornerRadius = width * 0.5;
        userView.layer.masksToBounds = YES;
        MBUser *user = self.chaoYangUsers[i];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:user.photo] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                userView.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1];
            });
        }];
        // 设置监听
        userView.userInteractionEnabled = YES;
        [userView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChaoYang:)]];
        userView.tag = i;
        [self.scrollView addSubview:userView];
    }
    
}


- (IBAction)clickClose:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.clickDeviceShow) {
        self.clickDeviceShow(sender.selected);
    }
}











@end
