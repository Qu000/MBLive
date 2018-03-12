//
//  MBLiveEndView.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/9.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBLiveEndView.h"

@interface MBLiveEndView()
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookOtherBtn;
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;

@end
@implementation MBLiveEndView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self maskRadius:self.quitBtn];
    [self maskRadius:self.lookOtherBtn];
    [self maskRadius:self.quitBtn];
    
}
- (void)maskRadius:(UIButton *)btn
{
    btn.layer.cornerRadius = btn.height * 0.5;
    btn.layer.masksToBounds = YES;
    if (btn != self.followBtn) {
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = KeyColor.CGColor;
    }
}

+(instancetype)liveEndView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (IBAction)follow:(id)sender {
    [sender setTitle:@"关注成功" forState:UIControlStateNormal];
}

- (IBAction)lookOther {
    if (self.lookOtherBlock){
        self.lookOtherBlock();
    }
}

- (IBAction)quit {
    if (self.quitBlock){
        self.quitBlock();
    }
}





@end
