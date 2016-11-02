//
//  LYModelAttribute.h
//  LYModelFilter
//
//  Created by LongYi on 16/10/24.
//  Copyright © 2016年 joylong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LYModelAttributeType) {
    LYModelAttributeTypeProperty,
    LYModelAttributeTypeValue
};

@interface LYModelAttribute : NSObject

@property (nonatomic, strong) id value;

@property (nonatomic, assign) LYModelAttributeType type;

@end
