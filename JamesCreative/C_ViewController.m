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
