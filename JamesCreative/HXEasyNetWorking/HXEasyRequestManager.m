//
//  HXEasyRequestManager.m
//  JamesCreative
//
//  Created by James on 2019/11/21.
//  Copyright © 2019 James. All rights reserved.
//

#import "HXEasyRequestManager.h"
#import "HXEasyNetWorking.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#import <pthread/pthread.h>


#define Lock    pthread_mutex_lock(&_mutex);
#define Unlock  pthread_mutex_unlock(&_mutex);

@interface HXEasyRequestManager()
@property (nonatomic, strong) AFHTTPSessionManager  *sessionManager;
@property (nonatomic, strong) AFJSONResponseSerializer  *jsonResponseSerializer;
@property (nonatomic, strong) AFXMLParserResponseSerializer  *xmlResponseSerialzier;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, HXEasyRequest *>  *requestRecordsDic;
@end



@implementation HXEasyRequestManager
{
    pthread_mutex_t _mutex;
}
#pragma mark - Life Cycle
+ (instancetype)sharedManager {
    static HXEasyRequestManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXEasyRequestManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        pthread_mutex_init(&_mutex, NULL);
    }
    return self;
}
#pragma mark - System Method

#pragma mark - Public Method
- (void)sendRequest:(HXEasyRequest *)request {
    
    if (!request) {
        return;
    }
    NSError *error;
//    request.sessionTask = [self _sessionTaskForRequest:request error:&error];
    request.sessionTask.priority = request.requestPriority;
    
    if (error) {
        
        return;
    }
    
    
    [self _recordRequest:request];
    
    [request.sessionTask resume];

}

- (void)cancelRequest:(HXEasyRequest *)request {
    if (!request) {
        return;
    }
    [request.sessionTask cancel];
    [self _removeRecordRequest:request];
}

- (void)cancelRequests:(NSArray<HXEasyRequest *> *)requests {
    for (HXEasyRequest *item in requests) {
        [self cancelRequest:item];
    }
}

- (void)cancelAllRequests {
    Lock
    NSArray *requests = [self.requestRecordsDic allValues];
    Unlock
    [self cancelRequests:requests];
}

#pragma mark - Override

#pragma mark - Private Method
- (void)_requestCompleted:(HXEasyRequest *)request error:(NSError *)error urlResponse:(NSURLResponse *)urlResponse responseObject:(id)responseObject {
//    Lock
//    HXBaseRequest *recordRequest = self.requestRecordsDic[@(request.taskIdentifier)];
//    Unlock
//
//    if (!recordRequest) {
//        return;
//    }
//
//
//    NSError * __autoreleasing serializationError = nil;
//    NSError * __autoreleasing validationError = nil;
//
//    NSError *requestError = nil;
//    BOOL succeed = NO;
//
//    request.responseObject = responseObject;
//    if ([request.responseObject isKindOfClass:[NSData class]]) {
//        request.responseData = responseObject;
//        request.responseString = [[NSString alloc] initWithData:responseObject encoding:[YTKNetworkUtils stringEncodingWithRequest:request]];
//
//        switch (request.responseSerializerType) {
//            case YTKResponseSerializerTypeHTTP:
//                // Default serializer. Do nothing.
//                break;
//            case YTKResponseSerializerTypeJSON:
//                request.responseObject = [self.jsonResponseSerializer responseObjectForResponse:task.response data:request.responseData error:&serializationError];
//                request.responseJSONObject = request.responseObject;
//                break;
//            case YTKResponseSerializerTypeXMLParser:
//                request.responseObject = [self.xmlParserResponseSerialzier responseObjectForResponse:task.response data:request.responseData error:&serializationError];
//                break;
//        }
//    }
//    if (error) {
//        succeed = NO;
//        requestError = error;
//    } else if (serializationError) {
//        succeed = NO;
//        requestError = serializationError;
//    } else {
//        succeed = [self validateResult:request error:&validationError];
//        requestError = validationError;
//    }
//
//    if (succeed) {
//        [self requestDidSucceedWithRequest:request];
//    } else {
//        [self requestDidFailWithRequest:request error:requestError];
//    }
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self removeRequestFromRecord:request];
//        [request clearCompletionBlock];
//    });
}

#pragma mark Assist Method
- (AFHTTPRequestSerializer *)_requestSerializerFor:(HXEasyRequest *)request {
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    if (request.requestSerializerType == HXEasyRequestSerializerType_HTTP) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    requestSerializer.timeoutInterval = request.requestTimeoutInterval;
    if ([HXEasyRequestGlobalConfig sharedConfig].userNameForAuthorizationHeaderField && [HXEasyRequestGlobalConfig sharedConfig].passwordForAuthorizationHeaderField) {
        [requestSerializer setAuthorizationHeaderFieldWithUsername:[HXEasyRequestGlobalConfig sharedConfig].userNameForAuthorizationHeaderField
                                                          password:[HXEasyRequestGlobalConfig sharedConfig].passwordForAuthorizationHeaderField];
    }
    
    if (request.requestHeadersDic) {
        for (NSString *key in request.requestHeadersDic.allKeys) {
            NSString *value = request.requestHeadersDic[key];
            [requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    return requestSerializer;
}

- (NSURLSessionTask *)_sessionTaskForRequest:(HXEasyRequest *)request error:(NSError **)error {
    
    AFHTTPRequestSerializer *requestSerializer = [self _requestSerializerFor:request];
    NSString *urlStr = [self _getURLStrFromRequest:request];
    
    NSMutableURLRequest *urlRequest = [requestSerializer requestWithMethod:request.requestMethodStr URLString:urlStr parameters:request error:error];
    
    if (error) {
        return nil;
    }
    
    
    return [self.sessionManager dataTaskWithRequest:urlRequest
             uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                 
             } downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                 
                 [self _requestCompleted:request error:error urlResponse:response responseObject:responseObject];
             }];
    
}

- (void)_recordRequest:(HXEasyRequest *)request {
    Lock
    self.requestRecordsDic[@(request.sessionTask.taskIdentifier)] = request;
    Unlock
}

- (void)_removeRecordRequest:(HXEasyRequest *)request {
    Lock
    [self.requestRecordsDic removeObjectForKey:@(request.sessionTask.taskIdentifier)];
    Unlock
}

- (NSString *)_getURLStrFromRequest:(HXEasyRequest *)request {
    
    if ([request.requestURLStr hasPrefix:@"http"]) {
        return request.requestURLStr;
    }
    
    
    NSString *urlPredicate=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",urlPredicate];
    if ([numberPre evaluateWithObject:request.requestURLStr]) {
        return request.requestURLStr;
    }
    
    NSString *baseURLStr = [HXEasyRequestGlobalConfig sharedConfig].baseURLStr;
    NSURL *baseURL = [NSURL URLWithString:baseURLStr];
    
    if (baseURLStr.length > 0 && ![baseURLStr hasSuffix:@"/"]) {
        baseURL = [baseURL URLByAppendingPathComponent:@""];
    }
    
    return [[NSURL URLWithString:request.requestURLStr relativeToURL:baseURL] absoluteString];
    
}

#pragma mark - Delegate

#pragma mark - Setter And Getter
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        NSURLSessionConfiguration  *sessionConfiguration = [HXEasyRequestGlobalConfig sharedConfig].sessionConfiguration ?: [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    }
    return _sessionManager;
}

- (AFJSONResponseSerializer *)jsonResponseSerializer {
    if (!_jsonResponseSerializer) {
        _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _jsonResponseSerializer;
}

- (AFXMLParserResponseSerializer *)xmlResponseSerialzier {
    if (!_xmlResponseSerialzier) {
        _xmlResponseSerialzier = [AFXMLParserResponseSerializer serializer];
    }
    return _xmlResponseSerialzier;
}

- (NSMutableDictionary<NSNumber *,HXEasyRequest *> *)requestRecordsDic {
    if (!_requestRecordsDic) {
        _requestRecordsDic = [NSMutableDictionary dictionary];
    }
    return _requestRecordsDic;
}

#pragma mark - Dealloc
- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
}
@end
//- (void)handleRequestResult:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error {
//
//}
//
//- (void)requestDidSucceedWithRequest:(YTKBaseRequest *)request {
//    @autoreleasepool {
//        [request requestCompletePreprocessor];
//    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [request toggleAccessoriesWillStopCallBack];
//        [request requestCompleteFilter];
//
//        if (request.delegate != nil) {
//            [request.delegate requestFinished:request];
//        }
//        if (request.successCompletionBlock) {
//            request.successCompletionBlock(request);
//        }
//        [request toggleAccessoriesDidStopCallBack];
//    });
//}
//
//- (void)requestDidFailWithRequest:(YTKBaseRequest *)request error:(NSError *)error {
//    request.error = error;
//    YTKLog(@"Request %@ failed, status code = %ld, error = %@",
//           NSStringFromClass([request class]), (long)request.responseStatusCode, error.localizedDescription);
//
//    // Save incomplete download data.
//    NSData *incompleteDownloadData = error.userInfo[NSURLSessionDownloadTaskResumeData];
//    if (incompleteDownloadData) {
//        [incompleteDownloadData writeToURL:[self incompleteDownloadTempPathForDownloadPath:request.resumableDownloadPath] atomically:YES];
//    }
//
//    // Load response from file and clean up if download task failed.
//    if ([request.responseObject isKindOfClass:[NSURL class]]) {
//        NSURL *url = request.responseObject;
//        if (url.isFileURL && [[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
//            request.responseData = [NSData dataWithContentsOfURL:url];
//            request.responseString = [[NSString alloc] initWithData:request.responseData encoding:[YTKNetworkUtils stringEncodingWithRequest:request]];
//
//            [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
//        }
//        request.responseObject = nil;
//    }
//
//    @autoreleasepool {
//        [request requestFailedPreprocessor];
//    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [request toggleAccessoriesWillStopCallBack];
//        [request requestFailedFilter];
//
//        if (request.delegate != nil) {
//            [request.delegate requestFailed:request];
//        }
//        if (request.failureCompletionBlock) {
//            request.failureCompletionBlock(request);
//        }
//        [request toggleAccessoriesDidStopCallBack];
//    });
//}
