//
//  C_ViewController.m
//  JamesCreative
//
//  Created by 周义进 on 2020/3/3.
//  Copyright © 2020 James. All rights reserved.
//

#import "C_ViewController.h"

#import "ParentRouterHeader.h"
#import "LMJVerticalFlowLayout.h"

#import <SDWebImage/SDWebImage.h>
#import "Teacher.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface TimerProxy : NSProxy
@property (nonatomic, weak) id   forwardTarget;

+ (instancetype)initWithForwardTarget:(id)target;
@end

@implementation TimerProxy

+ (instancetype)initWithForwardTarget:(id)target {
    TimerProxy *proxy = [TimerProxy alloc];
    proxy.forwardTarget = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.forwardTarget methodSignatureForSelector:sel];
}
- (void)forwardInvocation:(NSInvocation *)invocation{
    invocation.target = self.forwardTarget;
    [invocation invoke];
}



@end


typedef void(^blockTest)(void);
@import HXConvenientListView;

HXMacroReigisterService(C_ViewController, RouterURLString_CModule, RouterNamespace_JamesTestProject)

@interface C_ViewController ()
@property (nonatomic, strong) HXConvenientCollectionView *collectionView;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIImageView  *otherImageView;
@property (nonatomic, strong) NSTimer  *timer;

@end

@implementation C_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试";
    
//    [self autoLockTest];
//    [self performTest];
    [self IMPTest];
}

#pragma mark - IMP
- (void)IMPTest {
    id teacher = [Teacher new];
//    Method originalMethod = class_getInstanceMethod([Teacher class], @selector(print:b:));
    
    IMP imp = class_getMethodImplementation([Teacher class], @selector(print:b:));
    
    ((void (*)(id, SEL, NSString *, NSString *)) imp)(teacher, @selector(print:b:), @"aaaaaa", @"bbbbbb");
    
    u_int count;
    //class_copyMethodList 获取类的所有方法列表
    Method *mothList_f = class_copyMethodList([teacher class],&count) ;
    for (int i = 0; i < count; i++) {
        Method temp_f = mothList_f[i];
        // method_getImplementation 由Method得到IMP函数指针
        IMP imp_f = method_getImplementation(temp_f);
        // method_getName由Method得到SEL
        SEL name_f = method_getName(temp_f);

//        const char * name_s = sel_getName(name_f);
//        // method_getNumberOfArguments  由Method得到参数个数
//        int arguments = method_getNumberOfArguments(temp_f);
//        // method_getTypeEncoding  由Method得到Encoding 类型
//        const char * encoding = method_getTypeEncoding(temp_f);
        if (name_f == @selector(print:b:)) {
            imp = imp_f;
        }
//        NSLog(@"方法名：%@\n,参数个数：%d\n,编码方式：%@\n",[NSString stringWithUTF8String:name_s],
//        arguments,[NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
    
    ((void (*)(id, SEL, NSString *, NSString *)) imp)(teacher, @selector(print:b:), @"aaaaaa", @"bbbbbb");
    
    
    SEL sel = @selector(collectionViewTest); // 先获取方法编号SEL
    // 这样就可以成功执行方法，相当于[self addSubviewTemp:[UIView new] with:@"Temp"];
    ((void (*)(id, SEL)) objc_msgSend)(self, sel);
    
    [teacher beforeReplace];
    
    [self LogAllMethodsFromClass:teacher];
//    [teacher afterReplace];
//
//    [teacher beforeReplace];
}

//获取类的方法
- (void)LogAllMethodsFromClass:(id)obj
{
    u_int count;
    //class_copyMethodList 获取类的所有方法列表
    Method *mothList_f = class_copyMethodList([obj class],&count) ;
    for (int i = 0; i < count; i++) {
        Method temp_f = mothList_f[i];
        // method_getImplementation 由Method得到IMP函数指针
        IMP imp_f = method_getImplementation(temp_f);
        // method_getName由Method得到SEL
        SEL name_f = method_getName(temp_f);

        const char * name_s = sel_getName(name_f);
        // method_getNumberOfArguments  由Method得到参数个数
        int arguments = method_getNumberOfArguments(temp_f);
        // method_getTypeEncoding  由Method得到Encoding 类型
        const char * encoding = method_getTypeEncoding(temp_f);

        NSLog(@"方法名：%@\n,参数个数：%d\n,编码方式：%@\n",[NSString stringWithUTF8String:name_s],
        arguments,[NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
    
}


#pragma mark - collectionViewTest
- (void)collectionViewTest {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    for (NSInteger i = 0; i < 10; i++) {
        HXBaseConvenientViewModel *model = [HXBaseConvenientViewModel model];
        model.viewClassName = @"HXCollectionViewTestItemView";
        model.viewWidth = 50;
        model.viewHeight = 50;
        [self.collectionView.sourceArr addObject:model];
    }
    [self.collectionView reloadData];
}

#pragma mark - sdLoadTheSameImageConcurrentlyTest
- (void)sdLoadTheSameImageConcurrentlyTest {
    UIImageView *imageView = [[UIImageView alloc] init];
      [self.view addSubview:imageView];
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.center.equalTo(self.view);
          make.size.mas_equalTo(CGSizeMake(100, 100));
      }];
      
      
      UIImageView *otherImageView = [[UIImageView alloc] init];
      [self.view addSubview:otherImageView];
      [otherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.equalTo(self.view);
          make.centerY.equalTo(self.view).with.offset(150);
          make.size.mas_equalTo(CGSizeMake(100, 100));
      }];
      
      
      //https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2046313510,2749768343&fm=26&gp=0.jpg
    //https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587644377304&di=299c298a2d812aa4e038a0883746fcb9&imgtype=0&src=http%3A%2F%2Fpics0.baidu.com%2Ffeed%2F2934349b033b5bb5476c79bbcfdab63fb700bcc8.png%3Ftoken%3Ded8cb4b1262106173efa1d97ff100f71
      [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2046313510,2749768343&fm=26&gp=0.jpg"] placeholderImage:nil options:SDWebImageFromLoaderOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
          
      }];
      
      [otherImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2046313510,2749768343&fm=26&gp=0.jpg"] placeholderImage:nil options:SDWebImageFromLoaderOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
          
      }];
      
      
      [otherImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587644377304&di=299c298a2d812aa4e038a0883746fcb9&imgtype=0&src=http%3A%2F%2Fpics0.baidu.com%2Ffeed%2F2934349b033b5bb5476c79bbcfdab63fb700bcc8.png%3Ftoken%3Ded8cb4b1262106173efa1d97ff100f71"] placeholderImage:nil options:SDWebImageFromLoaderOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
          
      }];
}

#pragma mark - performTest
- (void)performTest {
    
    __weak typeof(self) w_self = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSRunLoop currentRunLoop] run];
        [w_self performSelector:@selector(test:d:) withObject:nil afterDelay:0];
        
    });
    

    NSLog(@"zzzzzzzcurrent:%@", [NSDate date]);
    TimerProxy *proxy = [TimerProxy initWithForwardTarget:self];
//    [NSTimer timerWithTimeInterval:1 target:proxy selector:@selector(_timerTriggerred:) userInfo:nil repeats:YES];
    self.timer = [NSTimer timerWithTimeInterval:1 target:proxy selector:@selector(_timerTriggerred:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [self.timer fire];
//  self.timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:proxy selector:@selector(_timerTriggerred:) userInfo:nil repeats:YES];
    NSLog(@"end end end");
    
    static NSString *name;
    if (!name) {
        name = @"wo shi wugui";
    }
    
    blockTest globalfornothing = ^{
        NSLog(@"selfsssss");
    };
    
    __weak blockTest globalforself = ^{
        NSLog(@"self:%@", self);
    };
    
    blockTest globalforstatic = ^{
        NSLog(@"globalforstatic name:%@", name);
    };
    
    
    blockTest stackforself = ^{
        NSLog(@"self:%@", self);
    };
    
    blockTest stackforstatic = ^{
        NSLog(@"stackforstatic:%@", name);
    };
    
    
    blockTest sss = ^{
        NSLog(@"self:%@", self);
    };
    NSLog(@"sss:%@", sss);
    
}

- (void)_timerTriggerred:(NSTimer *)timer {
    NSLog(@"current:%@", [NSDate date]);
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - invokeTest
- (void)invokeTest {
        NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@@"];
    //    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:dd"];
    //    signature = [[self class] instanceMethodSignatureForSelector:@selector(invoketTest:b:)];
    //    signature = [[self class] instanceMethodSignatureForSelector:@selector(test:d:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = self;
    //    id sss = @"sssss";
        double sss = 123;
    //    id sss = [NSObject new];
    //    [invocation setSelector:@selector(test:d:)];
        [invocation setSelector:@selector(invoketTest:b:)];
        [invocation setArgument:&sss atIndex:2];
        [invocation setArgument:&sss atIndex:3];
        [invocation invoke];
}

- (void)test:(float)a d:(double)b {
    NSLog(@"ssssssss");
}

- (void)invoketTest:(NSObject *)a b:(NSString *)b {
//    [a substringToIndex:1];
    
    
}

#pragma mark - KMP algorithm
- (void)test {
    NSString *targetStr = @"sdasdaabaabbabaabasdaasdasabaabbabaab";
    NSString *searchStr = @"abaabbabaab";
    NSMutableArray *nextArr = [NSMutableArray array];
    nextArr[0] = @(-1);
    
    for (NSInteger i = 1; i < searchStr.length; i++) {
        
        NSInteger j = [nextArr[i - 1] integerValue];
        
        NSString *currentStr = [searchStr substringWithRange:NSMakeRange(i, 1)];
        NSString *lastStr = [searchStr substringWithRange:NSMakeRange(j + 1, 1)];
        
        while (![currentStr isEqualToString:lastStr] && j >= 0) {
            j = [nextArr[j] integerValue];
        }
        
        lastStr = [searchStr substringWithRange:NSMakeRange(j + 1, 1)];
        
        if ([lastStr isEqualToString:currentStr]) {
            nextArr[i] = @(j + 1);
        }
        else {
            nextArr[i] = @(-1);
        }
        
    }
    
    NSLog(@"nextArr:%@", nextArr);
    
    NSInteger i = 0, j = 0;
    NSInteger begin = -1;
    while (i < targetStr.length) {
        
        NSString *targetItemStr = [targetStr substringWithRange:NSMakeRange(i, 1)];
        NSString *searchItemStr = [searchStr substringWithRange:NSMakeRange(j, 1)];
        if ([targetItemStr isEqualToString:searchItemStr]) {
            i++;
            j++;
            if (j == searchStr.length) {
                begin = i - searchStr.length;
                i++;
                j = 0;
            }
        }
        else {
            if (j == 0) {
                i++;
            }
            else {
                j = [nextArr[j - 1] integerValue] + 1;
            }
        }
    }
    if (begin >= 0) {
        NSLog(@"match:%@", [targetStr substringWithRange:NSMakeRange(begin, searchStr.length)]);
    }
}


/*查阅了GCC关于__attribute__说明，发现__attribute__((cleanup_function))属性。GCC说明如下：

cleanup (cleanup_function)

The cleanup attribute runs a function when the variable goes out of scope. This attribute can only be applied to auto function scope variables; it may not be applied to parameters or variables with static storage duration. The function must take one parameter, a pointer to a type compatible with the variable. The return value of the function (if any) is ignored. If -fexceptions is enabled, then cleanup_function is run during the stack unwinding that happens during the processing of the exception. Note that the cleanup attribute does not allow the exception to be caught, only to perform an action. It is undefined what happens if cleanup_function does not return normally.

简单来说，就是在修饰的变量作用域结束时，将自动调用cleanup_function函数。cleanup_function必须带有一个指向修饰变量的地址的参数。这时候，可以传入一个block的变量地址，并在cleanup_function执行这个block。
————————————————
*/

static void AutoLock(void (^__strong *lockBlock)(void)) {
    (*lockBlock)();
}

#pragma mark - clean-up
- (void)autoLockTest {
//    NSLock *lock = [NSLock new];
//    [lock lock];
    void (^autoLock)(void) __attribute__((cleanup(AutoLock), unused)) = ^{
        //变量作用域结束后运行的代码
        NSLog(@"i'm done");
//        [lock unlock];
    };
    
    
    
    NSLog(@"zzzzzzzz");
    NSLog(@"11111111");
    NSLog(@"22222222");
    
    
}


- (CGFloat)waterflowLayout:(LMJVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    return arc4random()%50;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(100, 50);
//}

- (HXConvenientCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        LMJVerticalFlowLayout *layout = [[LMJVerticalFlowLayout alloc] initWithDelegate:self];
//        layout.itemSize = CGSizeMake(100, 50);
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        layout.minimumLineSpacing = 12;
//        layout.minimumInteritemSpacing = 12;
        _collectionView = [[HXConvenientCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.ignoreTheDefaultProxyMethodForUICollectionViewDelegateFlowLayout = YES;
        _collectionView.delegate = (id<UICollectionViewDelegate>) self;
        _collectionView.dataSource = (id<UICollectionViewDataSource>) self;
    }
    return _collectionView;

}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"i'm dead");
}

@end
