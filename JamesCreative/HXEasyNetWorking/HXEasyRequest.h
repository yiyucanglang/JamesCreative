//
//  HXEasyRequest.h
//  JamesCreative
//
//  Created by James on 2019/11/21.
//  Copyright © 2019 James. All rights reserved.
//

@import UIKit;

#import "HXEasyRequestBasicDefine.h"


NS_ASSUME_NONNULL_BEGIN

@interface HXEasyRequest : NSObject
#pragma mark -Config

/// Set an absoulute or relative url path to the property
@property (nonatomic, copy) NSString  *requestURLStr;

@property (nonatomic, assign) HXEasyRequestMethodType   requestType;
@property (nonatomic, assign) HXEasyRequestSerializerType   requestSerializerType;
@property (nonatomic, assign) HXEasyResponseSerializerType   responseSerializerType;

@property (nonatomic, strong) id  requestParameters;
@property (nonatomic, strong) NSMutableDictionary  *requestHeadersDic;

@property (nonatomic, weak, nullable) id<HXEasyRequestDelegate>   delegate;

/**
 value between 0.0 and 1.0 default 0.0
 */
@property (nonatomic, assign) CGFloat   requestPriority;
/**
 Default: [HXGlobalConfig sharedConfig].requestTimeoutInterval
 */
@property (nonatomic, assign) NSTimeInterval   requestTimeoutInterval;

@property (nonatomic, assign) NSMutableArray<NSNumber *>   *businessSuccessCodesArr;

@property (nonatomic, assign) BOOL   logRequestInfo;

@property (nonatomic, strong, readonly) NSString *requestMethodStr;

/**
 store addtional info about request. Default is nil
 */
@property (nonatomic, strong, nullable) NSDictionary *userInfo;


@property (nonatomic, strong, readonly) NSURLSessionTask *sessionTask;


- (void)requestWillStart;

- (void)start;

- (void)requestWillFinished;

- (void)cancel;

//+ (HXBaseRequest *)requestWithRelativeURLStr:(NSString *)relativeURLStr requestType:(HXRequestMethodType)requestType requestSerializeType:(HXRequestSerializerType)requestSerializeType responseSerializeType:(HXResponseSerializerType)responseSerializeType;
@end

NS_ASSUME_NONNULL_END
