//
//  A_ViewController.m
//  JamesCreative
//
//  Created by James on 2019/12/26.
//  Copyright © 2019 James. All rights reserved.
//

#import "A_ViewController.h"



#import "ParentRouterHeader.h"

#import <AFNetworking/AFNetworking.h>

HXMacroReigisterService(A_ViewController, RouterURLString_AModule, RouterNamespace_JamesTestProject)


@interface A_ViewController ()

@end

@implementation A_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Module_A";
    self.view.backgroundColor = [UIColor redColor];
    NSArray *result = [self getAvailbaleTimeForTargetTime:@[@600, @75]];
    NSLog(@"result:%@", result);
    if (result) {
        NSInteger targetBegin = [result.firstObject integerValue];
        NSLog(@"begin:%@:%@", @(targetBegin/60), @(targetBegin%60));
//        NSInteger targetDuration = [result.lastObject integerValue];
    }
    
   
    
    UIButton *btns = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 80, 40)];
    [btns setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    [btns addTarget:self action:@selector(testImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btns];
    
    if ([NSClassFromString(@"UIViewController") isSubclassOfClass:[UIButton class]]) {
        NSLog(@"zzzzzzzz");
    }
    
    NSLog(@"request:%@", self.routeRequest.parameters);
    
//    [self testRoute];
    
    
    NSString *baseURLString = @"https://app-gateway.zmlearn.com";
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFJSONRequestSerializer *jsonSerializer = [AFJSONRequestSerializer serializer];
    
    
    NSMutableURLRequest *request = [jsonSerializer requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@/parentsApi/v2/global/systemConfigs", baseURLString] parameters:nil error:nil];
    [request setAllHTTPHeaderFields:[self commonHeaderFiled]];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"zzzz:%@", responseObject);
    }];
    
    [task resume];
}

 - (NSDictionary *)commonHeaderFiled {
    NSMutableDictionary *header = [NSMutableDictionary new];
    header[@"version"]          = @"3.1.3";
    header[@"platform"]         = @"iOS_iPhone";
    header[@"Api-Version"]      = @"3.1.3";
    header[@"accessToken"]      = @"";
    header[@"version-code"]     = @"313";
    header[@"device-token"]     = @"";
    return header;
}

- (void)testImage {
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.routeRequest.serviceCompletionHandler) {
            [self.routeRequest serviceCompletionHandlerWithResult:@"我是呆瓜" error:nil userInfo:nil];
        }
    }];
    
}


+(Class)moduleClassForRoute {
    return  [self class];
}

- (void)testRoute {
     NSTimeInterval begin, end, last;
        
    begin = CACurrentMediaTime();
    NSMutableArray *arr = [NSMutableArray array];
    
//    if ([[UIViewController class] respondsToSelector:@selector(alloc)]) {
//        NSLog(@"zzzzzzzzzz");
//    }

//    for (NSInteger i = 0; i < 9000; i++) {
//        [[HXRouter sharedManager] registerModule:[UIViewController class] URLString:[NSString stringWithFormat:@"parent://paper/index/%@", @(i)]];
//    }
//    for (NSInteger i = 0; i < 1000; i++) {
//        [[HXRouter sharedManager] registerModule:[UIViewController class] URLString:[NSString stringWithFormat:@"parent://course/submodule/%@", @(i)]];
//    }
    
    end = CACurrentMediaTime();
    printf("OSSpinLock:               %.2f ms\n", (end - begin) * 1000);
    
    NSInteger sasss;
    if ([[HXRouter sharedManager] canHandlerURLString:[NSString stringWithFormat:@"parent://paper/index/%@", @(400)] serverNamespace:RouterNamespace_JamesTestProject]) {
        sasss  = 200 + 300;
    }
    
    
    last = CACurrentMediaTime();
    printf("zzzzzzz:               %.2f ms\n", (last - end) * 1000);
}

- (NSArray *)getAvailbaleTimeForTargetTime:(NSArray *)targetTime {
    
    NSInteger targetBegin = [targetTime.firstObject integerValue];
    NSInteger targetDuration = [targetTime.lastObject integerValue];
    
    
    for (NSInteger i = 0; i < self.xxxArray.count - 1; i++) {
        
        NSArray *front = self.xxxArray[i];
        NSArray *behind = self.xxxArray[i + 1];
        NSInteger frontBegin = [front.firstObject integerValue];
        NSInteger frontDuration = [front.lastObject integerValue];
        
        NSInteger behindBegin = [behind.firstObject integerValue];
//        NSInteger behindDuration = [behind.lastObject integerValue];
        
        
        if (targetBegin >= frontBegin && targetBegin < behindBegin) {
            
            if (targetBegin >= frontBegin + frontDuration && targetBegin + targetDuration <= behindBegin) {//合法
                return targetTime;
            }
            
            return [self dddddForTimeForTargetTime:targetTime seperatorIndex:i];
            
            
        }
    }
    return nil;
}

- (NSArray *)dddddForTimeForTargetTime:(NSArray *)targetTime seperatorIndex:(NSInteger)index  {
//    NSInteger targetBegin = [targetTime.firstObject integerValue];
    NSInteger targetDuration = [targetTime.lastObject integerValue];
    
    
    for (NSInteger i = index; i < self.xxxArray.count - 1; i++) {
        
        NSArray *front = self.xxxArray[i];
        NSArray *behind = self.xxxArray[i + 1];
        NSInteger frontBegin = [front.firstObject integerValue];
        NSInteger frontDuration = [front.lastObject integerValue];
        
        NSInteger behindBegin = [behind.firstObject integerValue];
//        NSInteger behindDuration = [behind.lastObject integerValue];
        
        if (frontBegin + frontDuration + targetDuration <= behindBegin) {
            return @[@(frontBegin + frontDuration), @(targetDuration)];
        }
        
        
    }
    
    
    for (NSInteger i = 0; i <index - 1; i++) {
        
        NSArray *front = self.xxxArray[i];
        NSArray *behind = self.xxxArray[i + 1];
        NSInteger frontBegin = [front.firstObject integerValue];
        NSInteger frontDuration = [front.lastObject integerValue];
        
        NSInteger behindBegin = [behind.firstObject integerValue];
//        NSInteger behindDuration = [behind.lastObject integerValue];
        
        if (frontBegin + frontDuration + targetDuration <= behindBegin) {
            return @[@(frontBegin + frontDuration), @(targetDuration)];
        }

        
    }
    
    return nil;
}

- (NSArray *)xxxArray {
    static NSMutableArray *array;
    if (!array) {
        array = [[NSMutableArray alloc] init];
        [array addObject:@[@0, @45]];
        [array addObject:@[@225, @90]];
        [array addObject:@[@450, @105]];
        [array addObject:@[@590, @100]];
        [array addObject:@[@795, @55]];
        [array addObject:@[@945, @90]];
        [array addObject:@[@1185, @90]];
        [array addObject:@[@1335, @60]];
        
    }
    return array;
}
@end


//[
//  {
//    "startTime" : "2019-12-28 00:00:00",
//    "lesId" : 2120357154,
//    "endTime" : "2019-12-28 00:45:00",
//    "type" : 2
//  },
//  {
//    "startTime" : "2019-12-28 03:45:00",
//    "lesId" : 2120356988,
//    "endTime" : "2019-12-28 05:15:00",
//    "type" : 2
//  },
//  {
//    "startTime" : "2019-12-28 07:30:00",450 105
//    "lesId" : 2120356992,
//    "endTime" : "2019-12-28 09:15:00",
//    "type" : 2
//  },
//  {
//    "startTime" : "2019-12-28 09:50:00",590 100
//    "lesId" : 2120356994,
//    "endTime" : "2019-12-28 11:30:00",
//    "type" : 2
//  },
//  {
//    "startTime" : "2019-12-28 13:15:00",795 55
//    "lesId" : 2120356971,
//    "endTime" : "2019-12-29 14:10:00",
//    "type" : 0
//  },
//
//  {
//    "startTime" : "2019-12-28 15:45:00",945 90
//    "lesId" : 2120356988,
//    "endTime" : "2019-12-28 17:15:00",
//    "type" : 2
//  },
//
//  {
//    "startTime" : "2019-12-28 19:45:00", 1185 90
//    "lesId" : 2120356988,
//    "endTime" : "2019-12-28 21:15:00",
//    "type" : 2
//  },
//
//  {
//    "startTime" : "2019-12-28 22:15:00",1335 60
//    "lesId" : 2120356988,
//    "endTime" : "2019-12-28 23:15:00",
//    "type" : 2
//  }
//]
