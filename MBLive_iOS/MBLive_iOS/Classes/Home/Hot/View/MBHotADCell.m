//
//  MBHotADCell.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/7.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBHotADCell.h"
#import "MBHotADModel.h"

@implementation MBHotADCell

-(void)setTopADs:(NSArray *)topADs{
    _topADs = topADs;
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (MBHotADModel *topAD in topADs) {
        [imageUrls addObject:topAD.imageUrl];
    }
    MBBannerView * view = [MBBannerView carouselViewWithImageArray:imageUrls describeArray:nil];
    view.time = 2.0;
    view.delegate = self;
    view.frame = self.contentView.bounds;
    [self.contentView addSubview:view];
}
#pragma mark - MBBannerViewDelegate
-(void)carouselView:(MBBannerView *)carouselView clickImageAtIndex:(NSInteger)index{
    if (self.imageClickBlock) {
        self.imageClickBlock(self.topADs[index]);
    }
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
