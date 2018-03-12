//
//  MBLiveFlowLayout.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/12.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBLiveFlowLayout.h"

@implementation MBLiveFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
