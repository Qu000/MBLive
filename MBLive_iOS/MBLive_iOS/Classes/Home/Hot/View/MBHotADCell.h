//
//  MBHotADCell.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/7.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBBannerView.h"
@class MBHotADModel;

@interface MBHotADCell : UITableViewCell<MBBannerViewDelegate>

/** 顶部AD数组 */
@property (nonatomic, strong) NSArray *topADs;
/** 点击图片的block */
@property (nonatomic, copy) void (^imageClickBlock)(MBHotADModel *topAD);

@end
