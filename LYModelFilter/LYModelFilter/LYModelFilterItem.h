//
//  LYModelFilterItem.h
//  LYModelFilter
//
//  Created by LongYi on 16/10/23.
//  Copyright © 2016年 joylong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYModelAttribute.h"

typedef NS_ENUM(NSInteger, LYModelFilterItemEquationType) {
    LYModelFilterItemEquationTypeEqual,
    LYModelFilterItemEquationTypeLarge,
    LYModelFilterItemEquationTypeSmall,
    LYModelFilterItemEquationTypeLargeOrEqual,
    LYModelFilterItemEquationTypeSmallOrEqual,
    LYModelFilterItemEquationTypeMax,
    LYModelFilterItemEquationTypeMin
};

typedef NS_ENUM(NSInteger, LYModelFilterItemType) {
    LYModelFilterItemTypeAnd,
    LYModelFilterItemTypeOr,
};

@interface LYModelFilterItem : NSObject

@property (nonatomic, assign) LYModelFilterItemType type;

- (NSArray *)apply:(NSArray *)list;
- (LYModelFilterItem *(^)(NSString *property_name))property;
- (LYModelFilterItem *(^)(id value))equalTo;
- (LYModelFilterItem *(^)(id value))largeTo;
- (LYModelFilterItem *(^)(id value))smallTo;
- (LYModelFilterItem *(^)(id value))largeOrEqualTo;
- (LYModelFilterItem *(^)(id value))smallOrEqualTo;
- (LYModelFilterItem *(^)(NSString *property_name))max;
- (LYModelFilterItem *(^)(NSString *property_name))min;

@end

