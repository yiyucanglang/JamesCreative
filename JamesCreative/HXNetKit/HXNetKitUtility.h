//
//  HXNetKitUtility.h
//  JamesCreative
//
//  Created by 周义进 on 2020/2/28.
//  Copyright © 2020 James. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXNetRequestGlobalConfig.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const HXNetRequestMethodString_POST   = @"POST";
static NSString * const HXNetRequestMethodString_GET    = @"GET";
static NSString * const HXNetRequestMethodString_HEAD   = @"HEAD";
static NSString * const HXNetRequestMethodString_DELETE = @"DELETE";
static NSString * const HXNetRequestMethodString_PUT    = @"PUT";
static NSString * const HXNetRequestMethodString_PATCH  = @"PATCH";

typedef NS_ENUM(NSInteger, HXNetRequestMethodType) {
    HXNetRequestMethodType_POST,
    HXNetRequestMethodType_GET,
    HXNetRequestMethodType_HEAD,
    HXNetRequestMethodType_DELETE,
    HXNetRequestMethodType_PUT,
    HXNetRequestMethodType_PATCH,
};

typedef NS_ENUM(NSInteger, HXNetRequestSerializerType) {
    HXNetRequestSerializerType_JSON,
    HXNetRequestSerializerType_HTTP,
};


typedef NS_ENUM(NSInteger, HXNetResponseSerializerType) {
    HXNetResponseSerializerType_JSON,
    HXNetResponseSerializerType_HTTP,
};

static NSString const * HXNetMessageKey                = @"message";
static NSString const * HXNetCodeKey                   = @"code";
static NSString const * HXNetDataKey                   = @"data";
static NSString const * HXNetErrorKey                  = @"error";
static NSString const * HXNetCustomKey                 = @"custom";
static NSString const * HXNetUserInfoKey               = @"userInfo";
static NSString const * HXNetRequestKey                = @"request";
static NSString const * HXNetErrorPreHandledKey        = @"errorPrehandled";


typedef void(^HXNetRequestCompletion)(BOOL success, NSDictionary * _Nullable userInfo);
typedef void(^HXNetRequestProgress)(NSProgress *progress, NSDictionary * _Nullable userInfo);

#pragma mark -Tool


NSString* requestMethodString(HXNetRequestMethodType methodType);

typedef void (^HXNetRun)(void);

void HXNetAsyncRun(HXNetRun run);
void HXNetAsyncRunInMain(HXNetRun run);
void HXNetAsynRunInQueue(dispatch_queue_t queue, HXNetRun run);
void HXNetSynRunInQueue(dispatch_queue_t queue, HXNetRun run);

#pragma mark -Delegate

@class HXNetBaseRequest;
@protocol HXNetRequestDelegate <NSObject>
//- (void)requestSuceess:(NSString )
@end

@protocol HXNetRequestDataSource <NSObject>


@end

@protocol HXNetRequestInterceptor <NSObject>

@optional
- (void)requestWillStart:(HXNetBaseRequest *)request;
- (void)requestWillStop:(HXNetBaseRequest *)request;
@end


NS_ASSUME_NONNULL_END
