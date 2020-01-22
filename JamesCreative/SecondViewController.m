//
//  SecondViewController.m
//  JamesCreative
//
//  Created by James on 2019/11/27.
//  Copyright © 2019 James. All rights reserved.
//

#import "SecondViewController.h"

#import "ParentRouterHeader.h"

#import "Teacher.h"
//static NSString *test = @"test";

extern NSString *const XXVCLoginSuccessNotification;

/// WebCache options
typedef NS_OPTIONS(NSUInteger, aaaaSDWebImageOptions) {
    /**
     * By default, when a URL fail to be downloaded, the URL is blacklisted so the library won't keep trying.
     * This flag disable this blacklisting.
     */
    aaaaSDWebImageRetryFailed = 1 << 10,
    
    /**
     * By default, image downloads are started during UI interactions, this flags disable this feature,
     * leading to delayed download on UIScrollView deceleration for instance.
     */
    aaaaSDWebImageLowPriority = 1 << 11,
    
};

@interface Node : NSObject
@property (nonatomic, strong) Node  *next;
@property (nonatomic, assign) NSInteger   data;

@end

@implementation Node

@end

@interface SecondViewController ()
@property (nonatomic, strong) NSURLSession  *session;
@property (nonatomic, strong) NSTimer  *timer;

@property (nonatomic, strong) NSString  *a;
@property (nonatomic, copy) NSString  *b;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二";
    [self testFour];
    self.view.backgroundColor = [UIColor orangeColor];
//    Teacher *teacheer = [Teacher new];
//    teacheer.delegate = self;
//    [teacheer zzzz];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"1"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"2"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"3"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"4"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"5"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"6"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = 1; i < 7; i++) {
            NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@", @(i)]]);
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];

        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             for (NSInteger i = 1; i < 7; i++) {
                       NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@", @(i)]]);
             }
        });

    });
//
}

- (void)testFive {
    Node *node1 = [Node new];
    node1.data = 1;
    
    Node *node2 = [Node new];
    node2.data = 2;
    
    Node *node3 = [Node new];
    node3.data = 3;
    
    Node *node4 = [Node new];
    node4.data = 4;
    
    Node *node5 = [Node new];
    node5.data = 5;
    
    node1.next = node2;
    node2.next = node3;
    node3.next = node4;
    node4.next = node5;
    
    [self deleteData:node1 target:3];
}

- (void)deleteData:(Node *)node target:(NSUInteger)x {
    
}


- (void)testFour {
    NSMutableString *zzz = [NSMutableString stringWithString:@"11111"];
    self.a = zzz;
    self.b = zzz;
    NSLog(@"a:%@--%p--\%p | b:%@--\%p--\%p | zzz:%@--\%p--\%p", self.a, self.a, &_a, self.b, self.b, &_b, zzz, zzz, &zzz);
    [zzz appendString:@"2222"];
    NSLog(@"a:%@--\%p--\%p | b:%@--\%p--\%p | zzz:%@--\%p--\%p", self.a, self.a, &_a, self.b, self.b, &_b, zzz, zzz, &zzz);
}

- (void)testThree {
    
    NSMutableAttributedString *st  = [[NSMutableAttributedString alloc] initWithString:XXVCLoginSuccessNotification];
    
    aaaaSDWebImageOptions zzzz  = aaaaSDWebImageLowPriority;
    BOOL ggggg = (zzzz & aaaaSDWebImageLowPriority);
    BOOL sss = NO || (zzzz & aaaaSDWebImageLowPriority);
}

- (void)testTwo {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(print:) userInfo:@{@"1111" : @"zzzzzzzz"} repeats:YES];
}

- (void)print:(NSTimer *)timer {
    
}

- (void)testOne {
    self.session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:[NSURL URLWithString:@"https://www.baidu.com"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", self);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [dataTask resume];
    });
}

- (void)dealloc {
    NSLog(@"dealloc:%@", NSStringFromClass([self class]));
}

@end
