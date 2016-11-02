//
//  LYModelFilter.m
//  LYModelFilter
//
//  Created by LongYi on 16/10/23.
//  Copyright © 2016年 joylong. All rights reserved.
//

#import "LYModelFilter.h"
#import "LYModelFilterItem.h"
@interface LYModelFilter()
// 应用规则合集
@property (nonatomic, strong) NSMutableArray *rules;
// 限制的类名
@property (nonatomic, strong) NSString *targetClassName;
// 需要过滤出来的类型名称
@property (nonatomic, strong) NSString *filterPropertyName;

@property (nonatomic, strong) id target;

@end

@implementation LYModelFilter

- (instancetype)init {
    self = [super init];
    if (self) {
        _rules = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithObj:(id)obj {
    self = [self init];
    if (self) {
        _target = [obj copy];
    }
    return self;
}

- (NSArray *)apply {
    NSArray *list = [self.rules copy];
    id filterdObj = [self ly__filterClass];
    NSMutableArray *resultList = [NSMutableArray arrayWithArray:filterdObj];
    
    for (LYModelFilterItem *item in list) {
        if (item.type == LYModelFilterItemTypeAnd) {
            resultList = [[item apply:resultList] mutableCopy];
        } else if (item.type == LYModelFilterItemTypeOr) {
            NSArray *temp = [item apply:filterdObj];
            for (id obj in temp) {
                if (![resultList containsObject:obj]) {
                    [resultList addObject:obj];
                }
            }
        }
    }
    
    if ([self.filterPropertyName length] > 0) {
        resultList = [resultList valueForKeyPath:self.filterPropertyName];
    }
    return resultList;
}

- (LYModelFilter *(^)(NSString *))filter {
    return ^(NSString *filterPropertyName) {
        self.filterPropertyName = filterPropertyName;
        return self;
    };
}

- (LYModelFilter *(^)(NSString *))className {
    return ^(NSString *className) {
        self.targetClassName = className;
        return self;
    };
}

- (LYModelFilterItem *(^)())OR_ONE {
    return ^() {
        LYModelFilterItem *item = [[LYModelFilterItem alloc] init];
        item.type = LYModelFilterItemTypeOr;
        [self.rules addObject:item];
        return item;
    };
}

- (LYModelFilterItem *(^)())AND_ONE {
    return ^() {
        LYModelFilterItem *item = [[LYModelFilterItem alloc] init];
        item.type = LYModelFilterItemTypeAnd;
        [self.rules addObject:item];
        return item;
    };
}

- (LYModelFilterItem *(^)())ONE {
    return ^() {
        LYModelFilterItem *item = [[LYModelFilterItem alloc] init];
        item.type = LYModelFilterItemTypeAnd;
        [self.rules addObject:item];
        return item;
    };
}

#pragma mark - Match
// 过滤类型
- (id)ly__filterClass {
    if ([self.targetClassName length] > 0) {
        if ([self.target isKindOfClass:[NSArray class]]) {
            NSMutableArray *resultList = [NSMutableArray array];
            for (id obj in [self.target copy]) {
                if ([obj isKindOfClass:NSClassFromString(self.targetClassName)]) {
                    [resultList addObject:obj];
                }
            }
            return [resultList count] > 0 ? resultList : nil;
        } else {
            return [self.target isKindOfClass:NSClassFromString(self.targetClassName)] ? self.target : nil;;
        }
    } else {
        return self.target;
    }
}

@end
