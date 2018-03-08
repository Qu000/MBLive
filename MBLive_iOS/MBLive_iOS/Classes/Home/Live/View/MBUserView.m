//
//  MBUserView.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBUserView.h"
#import "MBUser.h"

@interface MBUserView()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *followLab;
@property (weak, nonatomic) IBOutlet UILabel *fansLab;
@property (weak, nonatomic) IBOutlet UIView *userView;

@end
@implementation MBUserView

+ (instancetype)userView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.followLab.text = [NSString stringWithFormat:@"%d",arc4random_uniform(1000) + 500];
    self.fansLab.text = [NSString stringWithFormat:@"%d",arc4random_uniform(10000) + 500];
    self.userView.layer.cornerRadius = 10;
    self.userView.layer.masksToBounds = YES;
}

-(void)setUser:(MBUser *)user{
    _user = user;
    self.nickNameLab.text = user.nickname;
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:user.photo] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.coverView.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1];
        });
    }];
}

- (IBAction)tipOffs:(id)sender {
    [self showInfo:@"举报成功"];
}

- (IBAction)close:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
}










@end
