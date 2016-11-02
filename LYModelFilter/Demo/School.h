//
//  School.h
//  LYModelFilter
//
//  Created by LongYi on 16/11/1.
//  Copyright © 2016年 joylong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

typedef NS_ENUM(NSInteger, SchoolType) {
    SchoolType_MiddleSchool,
    SchoolType_University,
    SchoolType_PrimarySchool
};

typedef NS_ENUM(NSInteger, GovernmentGrantsType) {
    GovernmentGrantsType_All,
    GovernmentGrantsType_Half,
    GovernmentGrantsType_None,
};

@interface SchoolInfo : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSTimeInterval startTime;

@end

@interface School : NSObject

@property (nonatomic, strong) NSArray<Student *>* students;

@property (nonatomic, strong) NSDictionary *rank;

@property (nonatomic, strong) SchoolInfo *info;

@property (nonatomic, assign) SchoolType type;

- (GovernmentGrantsType)grantType;

@end
