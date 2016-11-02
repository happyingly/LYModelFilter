//
//  NSArray+LYModelFilter.m
//  LYFilterModelDemo
//
//  Created by LongYi on 16/11/1.
//  Copyright © 2016年 LongYi. All rights reserved.
//

#import "NSArray+LYModelFilter.h"

@implementation NSArray (LYModelFilter)

- (NSArray *)ly_makeRules:(void (^)(LYModelFilter *filter))block {
    LYModelFilter *modelFilter = [[LYModelFilter alloc] initWithObj:self];
    block(modelFilter);
    return [modelFilter apply];
}

@end
