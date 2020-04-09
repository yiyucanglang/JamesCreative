//
//  LeetCodeViewController.m
//  JamesCreative
//
//  Created by 周义进 on 2020/3/29.
//  Copyright © 2020 James. All rights reserved.
//

#import "LeetCodeViewController.h"
#import "ParentRouterHeader.h"

HXMacroReigisterService(LeetCodeViewController, RouterURLString_LeetCodeModule, RouterNamespace_JamesTestProject)


@interface TreeNode : NSObject
@property (nonatomic, assign) NSInteger   value;
@property (nonatomic, strong) TreeNode  *leftNode;
@property (nonatomic, strong) TreeNode  *rightNode;

- (void)exchangedLeftRightNode;

+ (TreeNode *)reverseBinaryTree:(TreeNode *)root;
@end

@implementation TreeNode

- (void)exchangedLeftRightNode {
    if (self) {
        TreeNode *node  = self.leftNode;
        self.leftNode = self.rightNode;
        self.rightNode = node;
    }
}

+ (TreeNode *)reverseBinaryTree:(TreeNode *)root {
    if (!root) {
        return nil;
    }
    [TreeNode reverseBinaryTree:root.leftNode];
    [TreeNode reverseBinaryTree:root.rightNode];
    [root exchangedLeftRightNode];
    return root;
}

@end


@interface LeetCodeViewController ()

@end

@implementation LeetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@(1), @(9), @(20), @(40), @(8), @(3), @(5)]];
//    //归并排序
//    [self _test_MergeSort];
    
//    //选择排序
//    [self _seledtSort:arr];
    
//    //插入排序
//    [self _insertSort:arr];
    
//    //二分插入排序
//    [self _binaryInsertSort:arr];
    
//    //冒泡排序
//    [self _bubbleSort:arr];
    
//    //快速排序
//    [self _quickSort:arr];
    
    //kmpTest
//    [self _kmpTest];
    
    //反转二叉树
    [self _reverseBinaryTree];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CATransition *transition = [CATransition animation];
    transition.startProgress = 0;//开始进度
    transition.endProgress = 1;//结束进度
    transition.type = kCATransitionReveal;//过渡类型
    transition.subtype = kCATransitionFromLeft;//过渡方向
    transition.duration = 1.f;
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.f];
    self.view.layer.backgroundColor = color.CGColor;
    [self.view.layer addAnimation:transition forKey:@"transition"];
}

#pragma mark - 反转二叉树
- (void)_reverseBinaryTree {
    TreeNode *node = [TreeNode new];
    node = [TreeNode reverseBinaryTree:node];
}


#pragma mark - KMP算法
- (void)_kmpTest {
    NSString *target = @"sdasasdasabaabbabaab231sdfsfsdfsdabaabbabaab";
    NSString *search = @"abaabbabaab";
    
    //保存seach及其子串 最长相同前缀后缀长度的值;(表示0~i的字符串的最长相同前缀后缀的长度)
    NSMutableArray *nextArr = [self _getNextArrWithString:search];
    
    NSInteger i = 0, j = 0;
    while (i < target.length) {
        
        NSString *targetItem = [target substringWithRange:NSMakeRange(i, 1)];
        NSString *searchItem = [search substringWithRange:NSMakeRange(j, 1)];
        if([targetItem isEqualToString:searchItem]) {
            i++;
            j++;
            if (j == search.length) {//找到匹配
                NSLog(@"beginIndex:%@ %@", @(i - search.length), [target substringWithRange:NSMakeRange(i - search.length, search.length)]);
                j = 0;
            }
        }
        else {
            if (j != 0) {
                j = [nextArr[j - 1] integerValue] + 1;
            }
            else {
                i++;
            }
            
        }
    }
    
}

- (NSMutableArray *)_getNextArrWithString:(NSString *)string {
    
    NSMutableArray *nextArr = [NSMutableArray array];
    nextArr[0] = @(-1);
    
    NSInteger i = 1;
    while (i < string.length) {
        NSInteger j = [nextArr[i - 1] integerValue];
        
        NSString *current = [string substringWithRange:NSMakeRange(i, 1)];
        NSString *pre= [string substringWithRange:NSMakeRange(j + 1, 1)];
        
        while (![current isEqualToString:pre] && j >= 0) {
            j = [nextArr[j] integerValue];
        }
        pre= [string substringWithRange:NSMakeRange(j + 1, 1)];
        if ([current isEqualToString:pre]) {
            nextArr[i] = @(j + 1);
        }
        else {
            nextArr[i] = @(-1);
        }
        i++;
    }
    NSLog(@"nextArr:%@", nextArr);
    return nextArr;
}

#pragma mark - 快速排序 不稳定
- (void)_quickSort:(NSMutableArray *)array {
    if (array.count < 2) {
        return;
    }
    [self _quickSort:array left:0 right:array.count -1];
    NSLog(@"result:%@", array);
}

- (void)_quickSort:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right  {
    NSInteger i = left;
    NSInteger j = right;
    
    if (i >= j) {
        return;
    }
    
    id key = array[i];
    while (i < j) {
        
        while (i < j && [key integerValue] <= [array[j] integerValue]) {
            j--;
        }
        array[i] = array[j];
        
        while ((i < j && [key integerValue] >= [array[i] integerValue]) ) {
            i++;
        }
        array[j] = array[i];
    }
    array[i] = key;
    NSLog(@"---%@----", array);
    [self _quickSort:array left:left right:i];
    [self _quickSort:array left:i + 1 right:right];
}

#pragma mark - 冒泡排序
- (void)_bubbleSort:(NSMutableArray *)array {
    for (NSInteger i = 0; i < array.count - 1; i++) {
        for (NSInteger j = 0; j < array.count - 1 - i; j++) {
            if ([array[j] integerValue] > [array[j + 1] integerValue]) {
                id temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
            }
        }
    }
    NSLog(@"result:%@", array);
}


#pragma mark - 二分插入排序 稳定
- (void)_binaryInsertSort:(NSMutableArray *)array {
    if (array.count < 2) {
        return;
    }
    for (NSInteger i = 1; i < array.count; i++) {
        NSInteger left = 0;
        NSInteger right = i - 1;
        id temp = array[i];
        while (left <= right) {
            NSInteger mid = (left + right) / 2;
            if ([array[mid] integerValue] > [temp integerValue]) {
                right = mid - 1;
            }
            else {
                left = mid + 1;
            }
        }
        for (NSInteger j = i - 1; j >= left; j--) {
            array[j + 1] = array[j];
        }
        array[left] = temp;
    }
    NSLog(@"result:%@", array);
}

#pragma mark - 插入排序 稳定
- (void)_insertSort:(NSMutableArray *)array {
    if (array.count < 2) {
        return;
    }
    for (NSInteger i = 1; i < array.count; i++) {
        NSInteger j = i - 1;
        id temp = array[i];
        while (j > -1 && ([array[j] integerValue] > [temp integerValue])) {
            array[j + 1] = array[j];
            j--;
        }
        array[j+1] = temp;
    }
    NSLog(@"result:%@", array);
}



#pragma mark - 选择排序 不稳定
// 4 4 0
- (void)_seledtSort:(NSMutableArray *)array {
    for (NSInteger i = 0; i < array.count - 1; i++) {
        NSInteger min = i;
        for (NSInteger j = i + 1; j < array.count; j++) {
            if ([array[j] integerValue] < [array[min] integerValue]) {
                min = j;
            }
        }
        if (min != i) {
            id temp = array[i];
            array[i] = array[min];
            array[min] = temp;
        }
        
    }
    NSLog(@"result:%@", array);
}

#pragma mark - 归并排序
- (void)_test_MergeSort {
    //分治法
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@(1), @(9), @(20), @(40), @(8), @(3), @(5)]];
    [self _mergeSort:arr];
    NSLog(@"result:%@", arr);
}

- (void)_mergeSort:(NSMutableArray *)arr {
    NSMutableArray *temp = [NSMutableArray array];
    [self _mergeSort:arr left:0 right:arr.count - 1 temArr:temp];
}

//0 1 2 3 4 【0-2、3-4】【0-1、2-2、3-3、4-4】、【0-0、1-1】
- (NSArray *)_mergeSort:(NSMutableArray *)arr left:(NSInteger)left right:(NSInteger)right temArr:(NSMutableArray *)temArr {
    if (left < right) {
        NSInteger mid = (left + right)/2;
        [self _mergeSort:arr left:left right:mid temArr:temArr];
        [self _mergeSort:arr left:mid + 1 right:right temArr:temArr];
        
        [self _mergeArr:arr left:left mid:mid right:right temArr:temArr];
    }
    return arr;
}
//合并有序数组
- (NSArray *)_mergeArr:(NSMutableArray *)arr left:(NSInteger)left mid:(NSInteger)mid right:(NSInteger)right temArr:(NSMutableArray *)temArr {
    NSInteger k = 0;
    NSInteger i = left;
    NSInteger m = mid;
    NSInteger j = mid + 1;
    NSInteger n = right;
    while (i <= m && j <= n) {
        if (arr[i] < arr[j]) {
            temArr[k] = arr[i];
            k++;
            i++;
        }
        else {
            temArr[k] = arr[j];
            k++;
            j++;
        }
    }
    while (i <= m) {
        temArr[k] = arr[i];
        k++;
        i++;
    }
    while (j <= n) {
        temArr[k] = arr[j];
        k++;
        j++;
    }
    
    for (NSInteger i = 0; i < k; i++) {
        arr[left + i] = temArr[i];
    }
    return arr;
}

@end
