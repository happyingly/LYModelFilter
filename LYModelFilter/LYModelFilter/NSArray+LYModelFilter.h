//
//  NSArray+LYModelFilter.h
//  LYFilterModelDemo
//
//  Created by LongYi on 16/11/1.
//  Copyright © 2016年 LongYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYModelFilter.h"

@interface NSArray (LYModelFilter)

- (id)ly_makeRules:(void(^)(LYModelFilter *filter))block;

@end
