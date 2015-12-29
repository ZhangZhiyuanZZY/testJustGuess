//
//  UIButton+Extension.m
//  疯狂猜图
//
//  Created by 章芝源 on 15/12/28.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
+ (UIButton *)buttonWithBackgroundImageForNor:(NSString *)imageBackNor BackgroundImageForHei:(NSString *)imageBackHei imageNor:(NSString *)imageNor imageHei:(NSString *)imageHei titleNor:(NSString *)titleNor titleHei:(NSString *)titleHei titleColorNor:(UIColor *)titleColorNor titleColorHei:(UIColor *)titleColorHei
{
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:imageBackNor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageBackHei] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:imageNor] forState:UIControlStateNormal];
    [button setTitle:titleNor forState:UIControlStateNormal];
    [button setTitleColor:titleColorNor forState:UIControlStateNormal];
    
    return button;
}

@end
