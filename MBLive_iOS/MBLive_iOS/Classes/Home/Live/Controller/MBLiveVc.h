//
//  MBLiveVc.h
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBHomeLiveModel;

@interface MBLiveVc : UICollectionViewController
/** 直播 */
@property (nonatomic, strong) NSArray *lives;
/** 当前的index */
@property (nonatomic, assign) NSUInteger currentIndex;

@end
