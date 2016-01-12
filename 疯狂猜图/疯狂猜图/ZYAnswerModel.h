//
//  ZYAnswerModel.h
//  疯狂猜图
//
//  Created by 章芝源 on 15/12/29.
//  Copyright © 2015年 ZZY. All rights reserved.
//
//答案/图片...的模型
#import <Foundation/Foundation.h>

@interface ZYAnswerModel : NSObject
///答案
@property(copy, nonatomic)NSString *answer;
///头像
@property(copy, nonatomic)NSString *icon;
///标题
@property(copy, nonatomic)NSString *title;
///答案对应的带选项
@property(strong, nonatomic)NSArray *options;

+ (instancetype)ZYAnswerModelWithDitc:(NSDictionary *)Dict;
- (instancetype)ZYAnswerModelWithDitc:(NSDictionary *)Dict;


@end
