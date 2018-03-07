//
//  MBHotCell.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/6.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBHotCell.h"

@interface MBHotCell()
@property (weak, nonatomic) IBOutlet UIView *headIcon;
@property (weak, nonatomic) IBOutlet UIView *locationBtn;
@property (weak, nonatomic) IBOutlet UIView *nameLab;
@property (weak, nonatomic) IBOutlet UIView *startIcon;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UIImageView *bigPicView;

@end

@implementation MBHotCell

-(void)setModel:(MBHomeLiveModel *)model{
    _model = model;

}













- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
