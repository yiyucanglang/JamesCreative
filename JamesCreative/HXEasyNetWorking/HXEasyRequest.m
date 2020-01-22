//
//  HXEasyRequest.m
//  JamesCreative
//
//  Created by James on 2019/11/21.
//  Copyright © 2019 James. All rights reserved.
//

#import "HXEasyRequest.h"
#import "HXEasyNetWorking.h"

@interface HXEasyRequest()
@property (nonatomic, strong, readwrite) NSURLSessionTask *sessionTask;
@end

@implementation HXEasyRequest
#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        self.requestTimeoutInterval = [HXEasyRequestGlobalConfig sharedConfig].requestTimeoutInterval;
    }
    return self;
}

#pragma mark - System Method

#pragma mark - Public Method
- (void)requestWillStart {
    
}

- (void)requestWillFinished {
    
}

- (void)start {
    [self requestWillStart];
    
    [[HXEasyRequestManager sharedManager] sendRequest:self];
}

- (void)cancel {
    [[HXEasyRequestManager sharedManager] cancelRequest:self];
}

#pragma mark - Override

#pragma mark - Private Method

#pragma mark - Delegate

#pragma mark - Setter And Getter
- (NSString *)requestMethodStr {
    switch (self.requestType)
    {
        case HXEasyRequestMethodType_POST:
            return @"POST";
        case HXEasyRequestMethodType_GET:
            return @"GET";
        case HXEasyRequestMethodType_PUT:
            return @"PUT";
        case HXEasyRequestMethodType_DELETE:
            return @"DELETE";
        case HXEasyRequestMethodType_PATCH:
            return @"PATCH";
        default:
            break;
    }
    return @"GET";
}
 
#pragma mark - Dealloc
@end
