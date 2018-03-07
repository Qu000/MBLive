//
//  MBAnchorViewCell.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/7.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBUser;

@interface MBAnchorViewCell : UICollectionViewCell
/** 主播*/
@property (nonatomic, strong) MBUser * user;
@end
