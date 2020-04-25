//
//  Teacher+Test.m
//  JamesCreative
//
//  Created by James on 2019/11/25.
//  Copyright © 2019 James. All rights reserved.
//

#import "Teacher+Test.h"

@implementation Teacher (Test)
+ (void)load {
    NSLog(@"Teacher (ZZTestZ)");
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//       NSLog(@"我是老师sdsdadasadaa");
//    }
//    return self;
//}

- (void)zzzz {
    NSLog(@"Teacher (Test) :zzzz");
}


- (void)print:(NSString *)a b:(NSString *)b {
    NSLog(@"Teacher (Test): a:%@ b:%@", a, b);
}
@end
