//
//  ViewController.m
//  JamesCreative
//
//  Created by James on 2019/11/20.
//  Copyright © 2019 James. All rights reserved.
//

#import "ViewController.h"
#import "Teacher.h"

#import "SecondViewController.h"

#import "MiddleTeacher.h"
#import "LowTeacher.h"

#import "A_ViewController.h"

#import "TestView.h"


#import "HXRouter.h"
#import "HXRouterHandler.h"
#import <objc/runtime.h>

#import "ParentRouterHeader.h"
#import "HXNetKit.h"



#define kImagePath(bundle, imageName, type, directoryName) [bundle pathForResource:[NSString stringWithFormat:@"%@@%@x", imageName, @([UIScreen mainScreen].scale)] ofType:type inDirectory:directoryName]

#define kimage(bundle, imageName, type, directoryName) [UIImage imageWithContentsOfFile:kImagePath(bundle, imageName, type, directoryName)]

#define kAIClassFeedBackImage(bundle, imageName) kimage(bundle, imageName, @"png", @"Feedback")

NSString *const XXVCLoginSuccessNotification = @"sssss";

@import HXUIKits;

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
}

- (void)UIConfig {
    
   UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(80, 100, 100, 40)];
   [btn setTitle:@"跳转" forState:UIControlStateNormal];
   [btn addTarget:self action:@selector(testTwo) forControlEvents:UIControlEventTouchUpInside];
   btn.backgroundColor = [UIColor redColor];
   [self.view addSubview:btn];
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(btn.frame) + 20, 200, 40)];
    [btn1 setTitle:@"跳转C_Module" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(_jumpC) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(btn1.frame) + 20, 200, 40)];
    [btn2 setTitle:@"Leetcode" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(_jumpLeetcode) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn2];
   
    MiddleTeacher *mid = [MiddleTeacher new];
    [mid zzzz];
    
    LowTeacher *zz  = [LowTeacher new];
    [zz zzzz];
    
    UIButton *btns = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 80, 40)];
    [btns setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    [btns addTarget:self action:@selector(testImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btns];

    NSString *urlString = @"https://www/";
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodeUrl = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    NSURL *url = [NSURL URLWithString:encodeUrl];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSLog(@"url:%@", url);
    
    UIFont *ddd = [UIFont fontWithName:@"ddddd" size:20];
    
    HXNetRequest *req = [HXNetRequest new];
//    req.requestURLString = @"sssss";
    NSInteger sss = -1;
    if (sss) {
        NSLog(@"zzzzzzzzzz");
    }
    
    
    
}

- (void)_jumpC {
    [[HXRouter sharedManager] handleURLString:RouterURLString_CModule serverNamespace:RouterNamespace_JamesTestProject];
}

- (void)_jumpLeetcode {
    [[HXRouter sharedManager] handleURLString:RouterURLString_LeetCodeModule serverNamespace:RouterNamespace_JamesTestProject];
}

- (void)bundleTest {
        UIImageView *ss = [[UIImageView alloc] initWithFrame:CGRectMake(100 + 100, 100, 200, 200)];
        [self.view addSubview:ss];
        
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Image.bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithPath:bundlePath];
        
    //    ss.image = [UIImage imageNamed:@"aiclass_selectbox_selected" inBundle:imageBundle compatibleWithTraitCollection:nil];

    //    ss.image = [UIImage imageNamed:@"aiclass_feedback_close" inBundle:imageBundle compatibleWithTraitCollection:nil];
        
        NSString *imageName = [NSString stringWithFormat:@"%@@%@x", @"aiclass_feedback_close", @([UIScreen mainScreen].scale)];
        
        NSString *imagePath = kImagePath(imageBundle, @"aiclass_feedback_close", @"png", @"Feedback");//[imageBundle pathForResource:imageName ofType:@"png" inDirectory:@"Feedback"];
        UIImage *image = kimage(imageBundle, @"aiclass_feedback_close", @"png", @"Feedback"); // [UIImage imageWithContentsOfFile:imagePath];//kimage(imageBundle, @"aiclass_feedback_close", @"png", @"Feedback"); /
        ss.image = kAIClassFeedBackImage(imageBundle, @"aiclass_feedback_close");
    //    [UIScreen mainScreen].scale
      
     NSTimeInterval begin, end;
    begin = CACurrentMediaTime();
    end = CACurrentMediaTime();
    
    printf("OSSpinLock:               %8.2f ms\n", (end - begin) * 1000);
        
}

#pragma mark -testTwo
- (void)testTwo {
    
    [self.view endEditing:YES];
    NSLog(@"zzzzzz");
    
    return;
    NSDictionary *dic = @{
        @"zzzzz" : @"dddddd",
        @"number" : @(20),
        @"ssssss" : @"woshis"
    };
    NSData *ssss = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *sssString = [[NSString alloc] initWithData:ssss encoding:NSUTF8StringEncoding];
    
    
    NSString *sssurl =  [NSString stringWithFormat:@"%@?key1=value1&key2=valu2&key3=%@", RouterURLString_AModule, sssString];
    
    
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodeUrl = [sssurl stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    
    
//    ViewController *zzz = [[HXRouter sharedManager] getServiceEntityWithURLString:encodeUrl nativeParameters:@{HXRouterModuleTransitioningStyleKey : @(HXModuleTransitioningStyle_Presenting), HXRouterIDKey : @"22", HXRouterNameKey : @"试卷详情"}];
    
    
    [[HXRouter sharedManager] handleURLString:RouterURLString_BModule serverNamespace:RouterNamespace_JamesTestProject];
    return;
    
    [[HXRouter sharedManager] handleURLString:encodeUrl serverNamespace:RouterNamespace_JamesTestProject nativeParameters:@{HXRouterModuleTransitioningStyleKey : @(HXModuleTransitioningStyle_Presenting), HXRouterIDKey : @"22", HXRouterNameKey : @"试卷详情"} serviceCompletionHandler:^(id  _Nullable resultData, NSError * _Nullable error, NSDictionary * _Nullable userInfo) {
        NSLog(@"reslutdata:%@", resultData);
    } routerSearchCompletion:^(NSError * _Nullable error, NSDictionary * _Nullable userInfo) {
        NSLog(@"error:%@", error);
    }];
    return;
    
    
    A_ViewController *nextVC = [A_ViewController new];
//     TestViewController *nextVC = [TestViewController new];
    
//    SecondViewController *nextVC = [SecondViewController new];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)testImage {
     A_ViewController *nextVC = [A_ViewController new];
    [self presentViewController:nextVC animated:YES completion:nil];
//     [self.navigationController pushViewController:nextVC animated:YES];.
}

#pragma mark -testOne
- (void)testOne {
    Teacher *teacher = [Teacher new];
    
    NSString *str = [self performSelector:@selector(connectStrings:b:c:) withObjects:@[@"hello ",@"everyone,",@"good morning"]];
    NSLog(@"%@",str);
}

- (NSString *)connectStrings:(NSString *)a b:(NSString *)b c:(NSString *)c {
    return [NSString stringWithFormat:@"%@%@%@",a,b,c];
}


- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    // 初始化方法签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    // 如果方法不存在
    if (!signature) {
        // 抛出异常
        NSString *reason = [NSString stringWithFormat:@"方法不存在 : %@",NSStringFromSelector(aSelector)];
        @throw [NSException exceptionWithName:@"error" reason:reason userInfo:nil];
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    // 参数个数signature.numberOfArguments 默认有一个_cmd 一个target 所以要-2
    NSInteger paramsCount = signature.numberOfArguments - 2;
    
    // 当objects的个数多于函数的参数的时候,取前面的参数
    // 当objects的个数少于函数的参数的时候,不需要设置,默认为nil
    paramsCount = MIN(paramsCount, objects.count);
    
    for (NSInteger index = 0; index < paramsCount; index++) {
        id object = objects[index];
        // 对参数为nil的处理
        if ([object isKindOfClass:[NSNull class]]) {
            continue;
        }
        [invocation setArgument:&object atIndex:index + 2];
    }
    
    // 调用方法
    [invocation invoke];
    
    // 获取返回值
    __unsafe_unretained id returnValue = nil;
    //signature.methodReturnLength == 0 说明给方法没有返回值
    if (signature.methodReturnLength) {
        //获取返回值
        [invocation getReturnValue:&returnValue];
    }
    
    
    return returnValue;
}

- (void)testRouter {
    NSString *a1 = @"parent://paper/index";
    NSString *a2 = @"parent://paper/list";
    NSString *a3 = @"parent";
    NSString *a4 = @"parent://paper/submodule/weblist";
    NSString *a5 = @"parent://paper/submodule/zzzz";
    
    
//    [[HXRouter sharedManager] registerModule:[HXRouterHandler new] URLString:a1];
//    [[HXRouter sharedManager] registerModule:[ViewController class] URLString:a2];
//    [[HXRouter sharedManager] registerModule:@"aaaaaaaaa" URLString:a3];
//    [[HXRouter sharedManager] registerModule:@"bbbbbbbbb" URLString:a4];
//    [[HXRouter sharedManager] registerModule:@"cccccccc" URLString:a5];
    
    dispatch_queue_t queue = dispatch_queue_create("HXRouter.RouterQueue", NULL);
    
    __block BOOL qqqq = NO;
    HXSynRunInQueue(queue, ^{
        NSLog(@"zzzzzzz");
        NSLog(@"z111");
        qqqq = YES;
        return;
        NSLog(@"33333");
        NSLog(@"44444");
        
    });
    
    if (object_isClass([ViewController class])) {
        NSLog(@"zzzzzzz");
    }
    
    if (object_isClass([HXRouterHandler class])) {
        NSLog(@"aaaaaaaa");
    }
    
    if (object_isClass([ViewController new])) {
        NSLog(@"1111111");
    }
    
    if ([[HXRouter sharedManager] canHandlerURLString:a1 serverNamespace:RouterNamespace_JamesTestProject]) {
        NSLog(@"canhandle:%@", a1);
    }
    if ([[HXRouter sharedManager] canHandlerURLString:a2 serverNamespace:RouterNamespace_JamesTestProject]) {
        NSLog(@"canhandle:%@", a2);
    }
    if ([[HXRouter sharedManager] canHandlerURLString:a3 serverNamespace:RouterNamespace_JamesTestProject]) {
        NSLog(@"canhandle:%@", a3);
    }
    if ([[HXRouter sharedManager] canHandlerURLString:a4 serverNamespace:RouterNamespace_JamesTestProject]) {
        NSLog(@"canhandle:%@", a4);
    }
    if ([[HXRouter sharedManager] canHandlerURLString:a5 serverNamespace:RouterNamespace_JamesTestProject]) {
        NSLog(@"canhandle:%@", a5);
    }
    
    if ([[HXRouter sharedManager] canHandlerURLString:@"parent://paper/submodule/ssssss" serverNamespace:RouterNamespace_JamesTestProject]) {
        NSLog(@"canhanssssssdle:%@", a5);
    }
    
    NSURL *url = [NSURL URLWithString:@"parent://中国人/ssss/日本人"];
        HXRouterHandler *handler = [HXRouterHandler new];
    //    [handler handleRequest:[HXRouterRequest new] error:nil];
    //    NSURLComponents *zzzzComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
        NSError *error;
        
    //    [HXRouterUtility checkURLString:@"" error:&error];
        
        NSLog(@"zzzzzz");
        
        url = [NSURL URLWithString:@"scheme:///index/path/active/zzz?key=1&key2=2&KEYWWW="];
        
    //    url = [NSURL URLWithString:@"hahha/zzz?key1=333" relativeToURL:[NSURL URLWithString:@"scheme://ssss/"]];
        
        NSURLComponents *noComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
        NSURLComponents *yesCompoonents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
        
        NSArray *array = [@"/sss/ddd/111" componentsSeparatedByString:@"/"];
        NSArray *array1 = [@"/sss/ddd/111/" componentsSeparatedByString:@"/"];
        NSArray *array2 = [@"sss/ddd/111" componentsSeparatedByString:@"/"];
        
        NSDictionary *dic = @{
            @"zzzzz" : @"dddddd",
            @"number" : @(20),
            @"ssssss" : @"woshis"
        };
        NSData *ssss = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *sssString = [[NSString alloc] initWithData:ssss encoding:NSUTF8StringEncoding];
        NSString *sssurl =  [NSString stringWithFormat:@"scheme://中国人/path/傻子?key=1&key2=2&key3=%@", sssString];
        
        
        NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *encodeUrl = [sssurl stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
        NSLog(@"1:%@", encodeUrl);
    //    encodeUrl = [encodeUrl stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    //    NSLog(@"\n2:%@", encodeUrl);
        
        url = [NSURL URLWithString:encodeUrl];
        noComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
        
        
        
        NSMutableString *outputStr = [NSMutableString stringWithString:encodeUrl];
    //    [outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
        outputStr = [outputStr stringByRemovingPercentEncoding];
        
        
    //    TestView *view = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 400, 600)];
    //    view.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:view];
    //
        
        dispatch_queue_t registerSerialQueue = dispatch_queue_create("HXRouter.ReigsterQueue", DISPATCH_QUEUE_CONCURRENT);
        
        NSMutableDictionary *sss = [NSMutableDictionary dictionary];
        NSMutableArray *arr = [NSMutableArray array];
    //    for (NSInteger i = 0; i < 30; i++) {
    //        dispatch_async(registerSerialQueue, ^{
    //            NSLog(@"index:%@ thread:%@", @(i), [NSThread currentThread]);
    //            [sss setObject:@(i) forKey:[NSString stringWithFormat:@"%@", @(i)]];
    //        });
    //    }
        
    //    for (NSInteger i = 0; i < 30; i++) {
    //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //            [arr addObject:@(i)];
    //        });
    //    }
}

@end
