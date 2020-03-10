//
//  HXNetRequestManager.h
//  JamesCreative
//
//  Created by 周义进 on 2020/2/18.
//  Copyright © 2020 James. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXNetBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const HXNetStatusChangedNotification;


@interface HXNetRequestManager : NSObject
@property (nonatomic, assign, readonly) BOOL netReachable;
@property (nonatomic, assign, readonly) BOOL netReachableViaWWAN;
@property (nonatomic, assign, readonly) BOOL netReachableViaWiFi;


+ (nullable instancetype)sharedManager;

- (void)sendRequest:(HXNetBaseRequest *)request;
- (void)cancelRequest:(HXNetBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
