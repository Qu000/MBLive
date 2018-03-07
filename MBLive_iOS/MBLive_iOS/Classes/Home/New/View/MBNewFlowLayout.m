//
//  MBNewFlowLayout.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/7.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBNewFlowLayout.h"

@implementation MBNewFlowLayout
- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat wh = (MBScreenWidth - 3) / 3.0;
    self.itemSize = CGSizeMake(wh , wh);
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
}
@end
