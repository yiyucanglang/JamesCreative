//
//  Person.m
//  JamesCreative
//
//  Created by James on 2019/11/25.
//  Copyright © 2019 James. All rights reserved.
//

#import "Person.h"

@implementation Person
+ (void)load {
    NSLog(@"Person");
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        NSLog(@"我是人");
//    }
//    return self;
//}

+ (void)initialize{
    
    NSLog(@"Person + initialize");
}
@end
