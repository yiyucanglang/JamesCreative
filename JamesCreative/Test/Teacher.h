//
//  Teacher.h
//  JamesCreative
//
//  Created by James on 2019/11/25.
//  Copyright © 2019 James. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Teacher : Person
@property (nonatomic, assign) id   delegate;
- (void)zzzz;

- (void)print:(NSString *)a b:(NSString *)b;

- (void)beforeReplace;

- (void)afterReplace;

@end

NS_ASSUME_NONNULL_END
