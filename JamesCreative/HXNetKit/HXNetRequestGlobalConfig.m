//
//  HXNetRequestGlobalConfig.m
//  JamesCreative
//
//  Created by 周义进 on 2020/2/14.
//  Copyright © 2020 James. All rights reserved.
//

#import "HXNetRequestGlobalConfig.h"

#import "HXNetRequestManager.h"

NSString * const HXNetStatusChangedNotification = @"HXNetStatusChangedNotification";

@implementation HXNetRequestGlobalConfig
+ (instancetype)sharedConfig {
    static HXNetRequestGlobalConfig *manage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[HXNetRequestGlobalConfig alloc] init];
        [HXNetRequestManager sharedManager];
    });
    
    return manage;
}


- (BOOL)netReachable {
    return [HXNetRequestManager sharedManager].netReachable;
}

- (BOOL)netReachableViaWiFi {
    return [HXNetRequestManager sharedManager].netReachableViaWiFi;
}

- (BOOL)netReachableViaWWAN {
    return [HXNetRequestManager sharedManager].netReachableViaWiFi;
}
@end
