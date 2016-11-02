//
//  Student.m
//  LYModelFilter
//
//  Created by LongYi on 16/11/1.
//  Copyright © 2016年 joylong. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString *)description {
    return [NSString stringWithFormat:@"name=%@,age=%@,score=%ld,height=%f,student_id=%ld", self.name, self.age, (long)self.score, self.height, self.student_id];
}

@end
