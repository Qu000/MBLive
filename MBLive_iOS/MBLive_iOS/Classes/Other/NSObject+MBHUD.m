//
//  NSObject+MBHUD.m
//  MBLive_iOS
//
//  Created by qujiahong on 2018/3/6.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "NSObject+MBHUD.h"

@implementation NSObject (MBHUD)
- (void)showInfo:(NSString *)info
{
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]) {
        [[[UIAlertView alloc] initWithTitle:@"喵播" message:info delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}
@end
