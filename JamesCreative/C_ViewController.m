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
@import HXConvenientListView;

HXMacroReigisterService(C_ViewController, RouterURLString_CModule, RouterNamespace_JamesTestProject)

@interface C_ViewController ()
@property (nonatomic, strong) HXConvenientCollectionView *collectionView;
@end

@implementation C_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试";
    
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
//    [UIApplication sharedApplication].statusBarStyle
    [self test];
    [self autoLockTest];
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

@end
