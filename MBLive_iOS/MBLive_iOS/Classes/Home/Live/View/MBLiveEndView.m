//
//  MBLiveEndView.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/9.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "MBLiveEndView.h"

@implementation MBLiveEndView

-(void)awakeFromNib{
    [super awakeFromNib];
    
}
+(instancetype)liveEndView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}








@end
