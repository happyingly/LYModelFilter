##LYModelFilter

一个提取子数组的工具，可以任意匹配数据格式，并得到结果

###1、安装

```
pod 'LYModelFilter'
```

###2、使用
####2.1、原始数据
```
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
```
####2.2、获取年龄大于等于14岁的学生
```
    id value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().property(@"age").largeOrEqualTo(@14);
    }];
    NSLog(@"student (age >= 14) : %@", value);
```

####2.3、获取年龄大于等于14岁或者分数小于等于70分的学生
```
    // age >= 14 || score <= 70
    id value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().property(@"age").largeOrEqualTo(@14);
        filter.OR_ONE().property(@"score").smallOrEqualTo(@70);
    }];
    
    NSLog(@"student (age >= 14 or score <= 70) : %@", value);
```
####2.4、获取年龄大于等于14岁且分数小于等于70分的学生
```
    // age >= 14 && score <= 70
    id value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().property(@"age").largeOrEqualTo(@14);
        filter.AND_ONE().property(@"score").smallOrEqualTo(@70);
    }];
    
    NSLog(@"student (age >= 14 and score <= 70) : %@", value);
```
####2.5、获取学号最大的学生
```
    // student_id max
    id value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().max(@"student_id");
    }];
    
    NSLog(@"student (student_id max) : %@", value);
```
####2.6、获取学号最小的学生
```
    // student_id min
    id value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().min(@"student_id");
    }];
    
    NSLog(@"student (student_id min) : %@", value);
```
####2.7、获取学号最小且年龄小于15的学生
```
    // student_id min and age <= 15
    id value = [aSchool.students ly_makeRules:^(LYModelFilter *filter) {
        filter.ONE().min(@"student_id");
        filter.AND_ONE().property(@"age").smallOrEqualTo(@15);
    }];
    
    NSLog(@"student (student_id min and age <= 15) : %@", value);
```

####2.8、获取数组中NSString类型，且内容是new1的数据
```
    NSMutableArray *temp1 = [NSMutableArray arrayWithArray:aSchool.students];
    [temp1 addObject:@"new1"];
    [temp1 addObject:@"new2"];
    [temp1 addObject:@"new3"];
    
    id value = [temp1 ly_makeRules:^(LYModelFilter *filter) {
        filter.className(@"NSString");
        filter.ONE().equalTo(@"new1");
    }];
    NSLog(@"value in temp1 : %@", value);
```

####2.9、自定义匹配规则(代码为找到名字中包含boy的数组)（version 1.0.1更新）
```
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
```