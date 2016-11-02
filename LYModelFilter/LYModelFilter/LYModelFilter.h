//
//  LYModelFilter.h
//  LYModelFilter
//
//  Created by LongYi on 16/10/23.
//  Copyright © 2016年 joylong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYModelFilterItem.h"

@interface LYModelFilter : NSObject

- (instancetype)initWithObj:(id)obj;

/**
 * @brief 引用规则
 
 * @return 返回符合条件的数组
 */
- (NSArray *)apply;

/**
 * @brief 设置类名，如果对象不属于此类，则直接忽略
 */
- (LYModelFilter *(^)(NSString *className))className;

/**
 * @brief 筛选出相应key的value
 */
- (LYModelFilter *(^)(NSString *filterPropertyName))filter;

/**
 * @brief 表示筛选条件的或
 */
- (LYModelFilterItem *(^)())OR_ONE;

/**
 * @brief 表示筛选条件的与
 */
- (LYModelFilterItem *(^)())AND_ONE;

/**
 * @brief 开始时需要使用本类，与AND_ONE同义
 */
- (LYModelFilterItem *(^)())ONE;

@end
