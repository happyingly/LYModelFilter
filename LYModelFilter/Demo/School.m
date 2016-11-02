//
//  School.m
//  LYModelFilter
//
//  Created by LongYi on 16/11/1.
//  Copyright © 2016年 joylong. All rights reserved.
//

#import "School.h"

@implementation SchoolInfo

- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@,startTime:%f", self.name, self.startTime];
}

@end

@implementation School

- (GovernmentGrantsType)grantType {
    switch (self.type) {
        case SchoolType_University:
            return GovernmentGrantsType_None;
            break;
        case SchoolType_MiddleSchool:
            return GovernmentGrantsType_Half;
            break;
        case SchoolType_PrimarySchool:
            return GovernmentGrantsType_All;
            break;
        default:
            return GovernmentGrantsType_None;
            break;
    }
}
- (NSString *)description {
    return [NSString stringWithFormat:@"students:%@,rank:%@,info:%@,type:%ld", self.students, self.rank, self.info, (long)self.type];
}
@end
