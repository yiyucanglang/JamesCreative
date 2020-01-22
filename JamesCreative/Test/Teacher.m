//
//  Teacher.m
//  JamesCreative
//
//  Created by James on 2019/11/25.
//  Copyright © 2019 James. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher
+ (void)load {
    NSLog(@"Teacher");
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        NSLog(@"我是老师");
//    }
//    return self;
//}

- (void)zzzz {
    NSLog(@"Teacher :zzzz");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"begin");
        [self.delegate class];
    });
}

+ (void)initialize{

    NSLog(@"Teacher + initialize");
}

@end
