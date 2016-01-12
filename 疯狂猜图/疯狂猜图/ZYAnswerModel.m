//
//  ZYAnswerModel.m
//  疯狂猜图
//
//  Created by 章芝源 on 15/12/29.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ZYAnswerModel.h"

@implementation ZYAnswerModel

- (instancetype)ZYAnswerModelWithDitc:(NSDictionary *)Dict
{
    [self setValuesForKeysWithDictionary:Dict];
    return self;
}

+ (instancetype)ZYAnswerModelWithDitc:(NSDictionary *)Dict
{
    return [[[ZYAnswerModel alloc]init]ZYAnswerModelWithDitc:Dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"key = %@, value = %@", key, value);
}
@end
