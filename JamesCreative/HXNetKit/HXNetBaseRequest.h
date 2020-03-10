//
//  HXNetBaseRequest.h
//  JamesCreative
//
//  Created by 周义进 on 2020/2/18.
//  Copyright © 2020 James. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreGraphics/CoreGraphics.h>

#import "HXNetKitUtility.h"



NS_ASSUME_NONNULL_BEGIN

@interface HXNetBaseRequest : NSObject

/// Set absolute path or relative path. When set  absolute path, baseURLString In HXNetRequestGlobalConfig will be ignored.
@property (nonatomic, copy) NSString  *requestURLString;
@property (nonatomic, assign) HXNetRequestMethodType       methodType;
@property (nonatomic, assign) HXNetRequestSerializerType   requestSerializerType;
@property (nonatomic, assign) HXNetResponseSerializerType  responseSerializerType;
@property (nonatomic, strong) id  parameters;


/// Priority highest.
@property (nonatomic, strong) NSMutableURLRequest *customURLRequest;

#pragma mark -
@property (nonatomic, strong) NSMutableDictionary  *header;

/// Default value : requestTimeoutInterval in HXNetRequestGlobalConfig
@property (nonatomic, assign) NSTimeInterval   requestTimeoutInterval;

/// Value between 0.0 and 1.0. Default 0.0
@property (nonatomic, assign) CGFloat   priority;

//It only works if responseSerializerType == HXNetResponseSerializerType_JSON.
@property (nonatomic, assign) BOOL removesKeysWithNullValues;


@property (nonatomic, assign) BOOL   logEnabled;
@property (nonatomic, assign) NSInteger retryCount;
@property (nonatomic, weak) id requestOwner;
@property (nonatomic, copy, nullable) HXNetRequestProgress uploadProgress;
@property (nonatomic, copy, nullable) HXNetRequestProgress downloadProgress;


@property (nonatomic, weak, nullable) id<HXNetRequestDelegate>  delegate;
@property (nonatomic, weak, nullable) id<HXNetRequestDataSource>  dataSource;
@property (nonatomic, weak, nullable) id<HXNetRequestInterceptor>  interceptor;

#pragma mark -
@property (nonatomic, copy, nullable)   NSString  *businessMessage;
@property (nonatomic, assign)           BOOL       businessCode;
@property (nonatomic, strong, nullable) id         businessResponseData;
@property (nonatomic, assign)           BOOL       requestSuccessFlag;
///  Store addtional info about request. Default is nil
@property (nonatomic, strong, nullable) NSDictionary *userInfo;

#pragma mark -
@property (nonatomic, strong, readonly) id responseObject;
@property (nonatomic, copy, readonly, nullable) HXNetRequestCompletion completion;
@property (nonatomic, strong, readonly) NSString *methodString;
@property (nonatomic, strong, readonly, nullable) NSURLSessionTask *sessionTask;

+ (HXNetBaseRequest * _Nullable)requestWithURLString:(NSString *)URLString
                                      methodType:(HXNetRequestMethodType)methodType
                                      parameters:(id _Nullable)parameters;

- (void)start;

- (void)startWithCompletion:(HXNetRequestCompletion _Nullable)completion;


- (void)cancel;

- (NSDictionary * _Nullable)parseResponse:(id _Nullable)response error:(NSError * _Nullable)error;

- (void)requestWillBegin;

- (void)requestWillEnd;

- (BOOL)shouldRetryCount;

/// This will be invoked when the request landing.
- (BOOL)shouldStopHandleRequest;

- (void)clean;
@end

NS_ASSUME_NONNULL_END
