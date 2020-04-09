//
//  CommunityHomeViewController.m
//  HXRouterDemo
//
//  Created by James on 2020/4/2.
//  Copyright © 2020 James. All rights reserved.
//

#import "CommunityHomeViewController.h"

#import "CommunityModuleHeader.h"
#import "ONLDynamicLoader.h"
//HXMacroReigisterService(CommunityHomeViewController, URLString_Community_Home, HXRouterNamespace_Community)
@interface CommunityHomeViewController ()

@end

@implementation CommunityHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CommunityHomeViewController";
    self.view.backgroundColor = [UIColor yellowColor];
}


CRDYML_FUNCTIONS_EXPORT_BEGIN(LEVEL_A)
NSLog(@"=====sadasdasdasdasdasdasdadasdasdasdasdasdLEVEL_A=ssssssssssssss=========");
CRDYML_FUNCTIONS_EXPORT_END(LEVEL_A)

@end
