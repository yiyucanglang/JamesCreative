//
//  HXNetBaseRequest.m
//  JamesCreative
//
//  Created by 周义进 on 2020/2/18.
//  Copyright © 2020 James. All rights reserved.
//

#import "HXNetBaseRequest.h"

#import "HXNetRequestManager.h"

@interface HXNetBaseRequest()
@property (nonatomic, strong) NSURLSessionTask *sessionTask;
@property (nonatomic, copy) HXNetRequestCompletion completion;
@end

@implementation HXNetBaseRequest
#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        self.requestTimeoutInterval = [HXNetRequestGlobalConfig sharedConfig].requestTimeoutInterval;
    }
    return self;
}

+ (HXNetBaseRequest *)requestWithURLString:(NSString *)URLString methodType:(HXNetRequestMethodType)methodType parameters:(id)parameters {
    HXNetBaseRequest *request = [HXNetBaseRequest new];
    request.requestURLString = URLString;
    request.methodType = methodType;
    request.parameters = parameters;
    
    return request;
}

#pragma mark - System Method

#pragma mark - Public Method

- (void)start {
    [[HXNetRequestManager sharedManager] sendRequest:self];
}

- (void)startWithCompletion:(HXNetRequestCompletion)completion {
    self.completion = completion;
    [[HXNetRequestManager sharedManager] sendRequest:self];
}

- (void)cancel {
    [[HXNetRequestManager sharedManager] cancelRequest:self];
}

- (void)parseResponse {
    
}


- (void)requestWillBegin {
    
}

- (void)requestWillEnd {
    
}

- (void)clean {
    self.completion = nil;
    self.downloadProgress = nil;
    self.uploadProgress = nil;
}


#pragma mark - Override

#pragma mark - Private Method

#pragma mark - Delegate

#pragma mark - Setter And Getter
- (NSString *)methodString {
    return requestMethodString(self.methodType);
}
 
#pragma mark - Dealloc
@end
