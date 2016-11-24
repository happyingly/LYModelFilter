//
//  ViewController.m
//  LYFilterModelDemo
//
//  Created by LongYi on 16/11/1.
//  Copyright © 2016年 LongYi. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "School.h"
#import "NSArray+LYModelFilter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    School *aSchool = [self aSchool];

    id value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().property(@"age").largeOrEqualTo(@14);
    }];
    NSLog(@"student (age >= 14) : %@", value);
    
    // age >= 14 || score <= 70
    value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().property(@"age").largeOrEqualTo(@14);
        filter.OR_ONE().property(@"score").smallOrEqualTo(@70);
    }];
    
    NSLog(@"student (age >= 14 or score <= 70) : %@", value);
    
    // age >= 14 && score <= 70
    value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().property(@"age").largeOrEqualTo(@14);
        filter.AND_ONE().property(@"score").smallOrEqualTo(@70);
    }];
    
    NSLog(@"student (age >= 14 and score <= 70) : %@", value);
    
    // student_id max
    value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().max(@"student_id");
    }];
    
    NSLog(@"student (student_id max) : %@", value);
    
    // student_id min
    value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().min(@"student_id");
    }];
    
    NSLog(@"student (student_id min) : %@", value);
    
    // student_id min and age <= 15
    value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().min(@"student_id");
        filter.AND_ONE().property(@"age").smallOrEqualTo(@15);
    }];
    
    NSLog(@"student (student_id min and age <= 15) : %@", value);
    
    
    NSMutableArray *temp1 = [NSMutableArray arrayWithArray:aSchool.students];
    [temp1 addObject:@"new1"];
    [temp1 addObject:@"new2"];
    [temp1 addObject:@"new3"];
    
    value = [temp1 ly_makeRules:^(LYModelFilter *filter) {
        filter.className(@"NSString");
        filter.ONE().equalTo(@"new1");
    }];
    NSLog(@"value in temp1 : %@", value);
    
    
    NSArray *boys = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        LYModelFilterItemCustomBlock block = ^BOOL(id left , id right) {
            if ([left rangeOfString:right].location != NSNotFound) {
                return YES;
            }
            return NO;
        };
        
        filter.ONE().property(@"name").custom(block, @"boy");
    }];
    NSLog(@"boys : %@", boys);
}

- (School *)aSchool {
    Student *student1 = [[Student alloc] init];
    student1.name = @"boy1";
    student1.age = @18;
    student1.score = 80;
    student1.height = 180.1f;
    student1.student_id = 11111111;
    
    Student *student2 = [[Student alloc] init];
    student2.name = @"boy2";
    student2.age = @17;
    student2.score = 80;
    student2.height = 180.1f;
    student2.student_id = 22222222;
    
    Student *student3 = [[Student alloc] init];
    student3.name = @"boy3";
    student3.age = @16;
    student3.score = 70;
    student3.height = 180.1f;
    student3.student_id = 33333333;
    
    Student *student4 = [[Student alloc] init];
    student4.name = @"boy4";
    student4.age = @15;
    student4.score = 60;
    student4.height = 145.9f;
    student4.student_id = 44444444;
    
    Student *student5 = [[Student alloc] init];
    student5.name = @"boy5";
    student5.age = @14;
    student5.score = 50;
    student5.height = 160.5f;
    student5.student_id = 55555555;
    
    Student *student6 = [[Student alloc] init];
    student6.name = @"boy6";
    student6.age = @13;
    student6.score = 40;
    student6.height = 175.9f;
    student6.student_id = 66666666;
    
    Student *student7 = [[Student alloc] init];
    student7.name = @"girl1";
    student7.age = @12;
    student7.score = 30;
    student7.height = 164;
    student7.student_id = 77777777;
    
    School *school = [[School alloc] init];
    school.students = [NSArray arrayWithObjects:student1, student2, student3, student4, student5, student6, student7, nil];
    school.info = [[SchoolInfo alloc] init];
    school.info.name = @"MonicaSchool";
    school.info.startTime = [[NSDate date] timeIntervalSince1970];
    school.rank = @{@(student1.student_id):student1, @(student2.student_id):student2, @(student3.student_id):student3, @(student4.student_id):student4, @(student5.student_id):student5};
    
    return school;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
