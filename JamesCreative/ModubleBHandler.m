//
//  ModubleBHandler.m
//  JamesCreative
//
//  Created by James on 2020/1/21.
//  Copyright © 2020 James. All rights reserved.
//

#import "ModubleBHandler.h"

#import "SecondViewController.h"
#import "HXRouter.h"
#import "ParentRouterHeader.h"

HXMacroReigisterService(ModubleBHandler, RouterURLString_BModule)

@implementation ModubleBHandler

- (id)serviceWithRequest:(HXRouterRequest *)request {
    
    UIViewController *targetViewController = [[NSClassFromString(@"SecondViewController") alloc] init];
    targetViewController.routeRequest = request;
    return targetViewController;
}

- (BOOL)shouldHandleWithRequest:(HXRouterRequest *)request error:(NSError *__autoreleasing  _Nullable *)error {
    
    [[HXRouter sharedManager] handleURLString:@"parent://modulea" nativeParameters:@{HXRouterModuleTransitioningStyleKey : @(HXModuleTransitioningStyle_Presenting)} serviceCompletionHandler:^(id  _Nullable resultData, NSError * _Nullable error, NSDictionary * _Nullable userInfo) {
        [self handleRequest:request];
    }];
    return NO;
}
@end
