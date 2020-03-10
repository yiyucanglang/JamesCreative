//
//  HXNetRequestGlobalConfig.h
//  JamesCreative
//
//  Created by 周义进 on 2020/2/14.
//  Copyright © 2020 James. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HXNetReachabilityStatusType) {
    HXNetReachabilityStatusType_Unknown = -1,
    HXNetReachabilityStatusType_NotReachable = 0,
    HXNetReachabilityStatusType_ReachableViaWWAN = 1,
    HXNetReachabilityStatusType_ReachableViaWiFi = 2,
};

typedef void(^HXNetReachabilityStatusChangedBlock)(HXNetReachabilityStatusType status);

/**
Posted when network reachability changes.
This notification assigns no notification object. The `userInfo` dictionary contains an `NSNumber` object under the `HXNetStatusChangedNotificationStatusKey` key, representing the `HXNetReachabilityStatusType` value for the current network reachability.
*/
FOUNDATION_EXPORT NSString * const HXNetStatusChangedNotification;
static NSString * const HXNetStatusChangedNotificationStatusKey = @"HXNetStatusChangedNotificationStatusKey";

@interface HXNetRequestGlobalConfig : NSObject

@property (nonatomic, strong, nullable) NSMutableDictionary  *publicHeader;
@property (nonatomic, strong, nullable) NSMutableDictionary  *publicParameters;
@property (nonatomic, strong, nullable) NSString  *baseURLStr;
@property (nonatomic, strong, nullable) NSURLSessionConfiguration  *sessionConfiguration;
@property (nonatomic, copy, nullable) NSString  *userNameForAuthorizationHeaderField;
@property (nonatomic, copy, nullable) NSString  *passwordForAuthorizationHeaderField;
/// Default: 15s
@property (nonatomic, assign) NSTimeInterval   requestTimeoutInterval;

@property (nonatomic, copy) HXNetReachabilityStatusChangedBlock netStatusChangedBlock;
@property (nonatomic, assign, readonly) BOOL netReachable;
@property (nonatomic, assign, readonly) BOOL netReachableViaWWAN;
@property (nonatomic, assign, readonly) BOOL netReachableViaWiFi;

+ (nullable instancetype)sharedConfig;

@end

NS_ASSUME_NONNULL_END
