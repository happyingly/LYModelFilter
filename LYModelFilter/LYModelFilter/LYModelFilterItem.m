//
//  LYModelFilterItem.m
//  LYModelFilter
//
//  Created by LongYi on 16/10/23.
//  Copyright © 2016年 joylong. All rights reserved.
//

#import "LYModelFilterItem.h"
#import "LYModelAttribute.h"

@interface LYModelFilterItem()

@property (nonatomic, strong) LYModelAttribute *firstAttr;
@property (nonatomic, strong) LYModelAttribute *secondAttr;
@property (nonatomic, assign) LYModelFilterItemEquationType equationType;

@end

@implementation LYModelFilterItem

- (NSArray *)apply:(NSArray *)list {
    if ([list count] == 0) return nil;
    
    NSMutableArray *propList = [NSMutableArray array];
    if (self.equationType == LYModelFilterItemCustom) {
        id arr = [self ly_custom:list];
        propList = arr;
    } else if (self.equationType == LYModelFilterItemEquationTypeMin || self.equationType == LYModelFilterItemEquationTypeMax) {
        id result = [self ly__maxOrMinObj:list];
        if (result) {
            [propList addObject:result];
        }
    } else {
        id arr = [self ly__matchProperty:list];
        propList = arr;
    }
    return propList;
}

- (LYModelFilterItem *(^)(NSString *property_name))property {
    return ^(NSString *property_name) {
        LYModelAttribute *item = [[LYModelAttribute alloc] init];
        item.type = LYModelAttributeTypeProperty;
        item.value = property_name;
        self.firstAttr = item;
        return self;
    };
}

- (LYModelFilterItem *(^)(id value))equalTo {
    return ^(id value) {
        LYModelAttribute *item = [[LYModelAttribute alloc] init];
        item.type = LYModelAttributeTypeValue;
        item.value = value;
        self.secondAttr = item;
        self.equationType = LYModelFilterItemEquationTypeEqual;
        return self;
    };
}
- (LYModelFilterItem *(^)(id value))largeTo {
    return ^(id value) {
        LYModelAttribute *item = [[LYModelAttribute alloc] init];
        item.type = LYModelAttributeTypeValue;
        item.value = value;
        self.secondAttr = item;
        self.equationType = LYModelFilterItemEquationTypeLarge;
        return self;
    };
}

- (LYModelFilterItem *(^)(id value))smallTo {
    return ^(id value) {
        LYModelAttribute *item = [[LYModelAttribute alloc] init];
        item.type = LYModelAttributeTypeValue;
        item.value = value;
        self.secondAttr = item;
        self.equationType = LYModelFilterItemEquationTypeSmall;
        return self;
    };
}

- (LYModelFilterItem *(^)(id value))largeOrEqualTo {
    return ^(id value) {
        LYModelAttribute *item = [[LYModelAttribute alloc] init];
        item.type = LYModelAttributeTypeValue;
        item.value = value;
        self.secondAttr = item;
        self.equationType = LYModelFilterItemEquationTypeLargeOrEqual;
        return self;
    };
}

- (LYModelFilterItem *(^)(id value))smallOrEqualTo {
    return ^(id value) {
        LYModelAttribute *item = [[LYModelAttribute alloc] init];
        item.type = LYModelAttributeTypeValue;
        item.value = value;
        self.secondAttr = item;
        self.equationType = LYModelFilterItemEquationTypeSmallOrEqual;
        return self;
    };
}

- (LYModelFilterItem *(^)(NSString *property_name))max {
    return ^(NSString *property_name) {
        LYModelAttribute *item = [[LYModelAttribute alloc] init];
        item.type = LYModelAttributeTypeProperty;
        item.value = property_name;
        self.firstAttr = item;
        self.equationType = LYModelFilterItemEquationTypeMax;
        return self;
    };
}

- (LYModelFilterItem *(^)(NSString *property_name))min {
    return ^(NSString *property_name) {
        LYModelAttribute *item = [[LYModelAttribute alloc] init];
        item.type = LYModelAttributeTypeProperty;
        item.value = property_name;
        self.firstAttr = item;
        self.equationType = LYModelFilterItemEquationTypeMin;
        return self;
    };
}

- (LYModelFilterItem *(^)(LYModelFilterItemCustomBlock block, id value))custom {
    return ^(LYModelFilterItemCustomBlock block, id value) {
        LYModelAttribute *item = [[LYModelAttribute alloc] init];
        item.block = block;
        item.value = value;
        self.secondAttr = item;
        self.equationType = LYModelFilterItemCustom;
        return self;
    };
}

#pragma mark - Match
- (id)ly_custom:(NSArray *)list {
    NSMutableArray *propList = [NSMutableArray array];
    
    NSArray *propertyList = [self.firstAttr.value componentsSeparatedByString:@"."];
    
    for (id obj in list) {
        id value = obj;
        for (NSString *propertyName in propertyList) {
            value = [value valueForKey:propertyName];
            if (value == nil) {
                break;
            }
        }
        if (value) {
            BOOL isTrue = self.secondAttr.block(value, self.secondAttr.value);
            if (isTrue) {
                [propList addObject:obj];
            }
        }
        
    }
    return propList;
}

- (id)ly__maxOrMinObj:(NSArray *)list {
    NSArray *propertyList = [self.firstAttr.value componentsSeparatedByString:@"."];
    id result = nil;
    NSInteger maxOrMin = self.equationType == LYModelFilterItemEquationTypeMax ? 0 : INT_MAX;
    
    for (id obj in list) {
        id value = obj;
        for (NSString *propertyName in propertyList) {
            value = [value valueForKey:propertyName];
            if (value == nil) {
                break;
            }
        }
        if (value) {
            if ([self ly__isStringOrNumber:value]) {
                NSInteger num = [value integerValue];
                if (self.equationType == LYModelFilterItemEquationTypeMax) {
                    if (num >= maxOrMin) {
                        maxOrMin = num;
                        result = obj;
                    }
                } else {
                    if (num <= maxOrMin) {
                        maxOrMin = num;
                        result = obj;
                    }
                }
            }
        }
    }
    return result;
}

- (id)ly__matchProperty:(NSArray *)list {
    NSMutableArray *propList = [NSMutableArray array];
    id firstObject = [list firstObject];
    if (self.firstAttr && self.secondAttr) {
        if ([self ly__isStringOrNumber:firstObject]) {
            return nil;
        }
        NSArray *propertyList = [self.firstAttr.value componentsSeparatedByString:@"."];
        for (id obj in list) {
            id value = obj;
            for (NSString *propertyName in propertyList) {
                value = [value valueForKey:propertyName];
                if (value == nil) {
                    break;
                }
            }
            if (value) {
                if ([self ly__isMatch:value]) {
                    [propList addObject:obj];
                }
            }
            
        }
    } else if (self.secondAttr) {
        if (![self ly__isStringOrNumber:firstObject]) {
            return nil;
        }
        
        
        for (id obj in list) {
            id value = obj;
            if (value) {
                if ([self ly__isMatch:value]) {
                    [propList addObject:obj];
                }
            }
        }
    }
    return propList;
}
- (BOOL)ly__isMatch:(id)obj {
    id value = self.secondAttr.value;
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [self ly__isMatchNumber:obj];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [self ly__isMatchString:obj];
    }
    else {
        return [self ly__isMatchObj:obj];
    }
    return NO;
}

- (BOOL)ly__isStringOrNumber:(id)obj {
    if ([obj isKindOfClass:[NSString class]]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)ly__isMatchNumber:(id)obj {
    id value = self.secondAttr.value;
    
    if ((strcmp([value objCType], @encode(float)) == 0) || (strcmp([value objCType], @encode(double)) == 0))
    {
        if (self.equationType == LYModelFilterItemEquationTypeEqual) {
            if ([obj floatValue] == [value floatValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeLarge) {
            if ([obj floatValue] > [value floatValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeLargeOrEqual) {
            if ([obj floatValue] >= [value floatValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeSmall) {
            if ([obj floatValue] < [value floatValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeSmallOrEqual) {
            if ([obj floatValue] <= [value floatValue]) {
                return YES;
            }
        }
        
    }
    else {
        if (self.equationType == LYModelFilterItemEquationTypeEqual) {
            if ([obj longLongValue] == [value longLongValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeLarge) {
            if ([obj longLongValue] > [value longLongValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeLargeOrEqual) {
            if ([obj longLongValue] >= [value longLongValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeSmall) {
            if ([obj longLongValue] < [value longLongValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeSmallOrEqual) {
            if ([obj longLongValue] <= [value longLongValue]) {
                return YES;
            }
        }
    }
    
    
    return NO;
}

- (BOOL)ly__isMatchString:(id)obj {
    id value = self.secondAttr.value;
    
    // 字符串只含有数字，可以进行比较
    if ([[obj stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0) {
        if (self.equationType == LYModelFilterItemEquationTypeEqual) {
            if ([obj longLongValue] == [value longLongValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeLarge) {
            if ([obj longLongValue] > [value longLongValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeLargeOrEqual) {
            if ([obj longLongValue] >= [value longLongValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeSmall) {
            if ([obj longLongValue] < [value longLongValue]) {
                return YES;
            }
        }
        else if (self.equationType == LYModelFilterItemEquationTypeSmallOrEqual) {
            if ([obj longLongValue] <= [value longLongValue]) {
                return YES;
            }
        }
    }
    // 字符串不仅仅含有数字，只能isEqualToString比较
    else {
        if (self.equationType == LYModelFilterItemEquationTypeEqual) {
            if ([value isEqualToString:obj]) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)ly__isMatchObj:(id)obj {
    id value = self.secondAttr.value;
    if (self.equationType == LYModelFilterItemEquationTypeEqual) {
        if ([value isEqual:obj]) {
            return YES;
        }
    }
    return NO;
}
@end
