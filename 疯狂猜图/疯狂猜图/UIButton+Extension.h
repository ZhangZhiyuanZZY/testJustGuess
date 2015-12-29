//
//  UIButton+Extension.h
//  疯狂猜图
//
//  Created by 章芝源 on 15/12/28.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import <UIKit/UIKit.h>
//四个选项按钮的分类
@interface UIButton (Extension)
+ (UIButton *)buttonWithBackgroundImageForNor:(NSString *)imageBackNor BackgroundImageForHei:(NSString *)imageBackHei imageNor:(NSString *)imageNor imageHei:(NSString *)imageHei titleNor:(NSString *)titleNor titleHei:(NSString *)titleHei titleColorNor:(UIColor *)titleColorNor titleColorHei:(UIColor *)titleColorHei;
@end
