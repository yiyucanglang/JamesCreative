//
//  HXNetRequestManager.m
//  JamesCreative
//
//  Created by 周义进 on 2020/2/18.
//  Copyright © 2020 James. All rights reserved.
//

#import "HXNetRequestManager.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#import <pthread/pthread.h>

@interface HXNetBaseRequest()
@property (nonatomic, strong, readwrite) NSURLSessionTask *sessionTask;
@property (nonatomic, strong, readwrite) id responseObject;
@end


@interface HXNetRequestManager()
@property (nonatomic, strong) AFHTTPSessionManager  *sessionManager;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, HXNetBaseRequest *>  *requestRecordsDic;
@property (nonatomic, strong) dispatch_queue_t  netSerialQueue;
@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;
@end

@implementation HXNetRequestManager
{
    pthread_mutex_t _mutex;
}

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        pthread_mutex_init(&_mutex, NULL);
    }
    return self;
}

+ (instancetype)sharedManager {
    static HXNetRequestManager *manage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[HXNetRequestManager alloc] init];
        manage.reachabilityManager = [AFNetworkReachabilityManager manager];
        [manage.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [HXNetRequestGlobalConfig sharedConfig].netStatusChangedBlock((HXNetReachabilityStatusType)status);
            [[NSNotificationCenter defaultCenter] postNotificationName:HXNetStatusChangedNotification object:nil userInfo:@{HXNetStatusChangedNotificationStatusKey : @(status)}];
        }];
        [manage.reachabilityManager startMonitoring];
    });
    
    return manage;
}

#pragma mark - System Method

#pragma mark - Public Method
- (void)sendRequest:(HXNetBaseRequest *)request {
    
    HXNetSynRunInQueue(self.netSerialQueue, ^{
       
        if (!request) {
            return;
        }
        
        NSError *error;
        request.sessionTask = [self _sessionTaskForRequest:request error:&error];
        request.sessionTask.priority = request.priority;
            
        if (error) {
            [self _requestCompleted:request error:error urlResponse:nil responseObject:nil];
            return;
        }
        
        [request requestWillBegin];
        
        [self _recordRequest:request];
        [request.sessionTask resume];
        
    });
    
}

- (void)cancelRequest:(HXNetBaseRequest *)request {
    
    HXNetSynRunInQueue(self.netSerialQueue, ^{
        [self _cancelRequest:request];
    });
}
 
- (void)cancelRequests:(NSArray<HXNetBaseRequest *> *)requests {
    
    HXNetSynRunInQueue(self.netSerialQueue, ^{
       
        for (HXNetBaseRequest *item in requests) {
            [self _cancelRequest:item];
        }
        
    });
}

- (void)cancelAllRequests {
    HXNetSynRunInQueue(self.netSerialQueue, ^{
       
        NSArray *requests = [self.requestRecordsDic allValues];
        for (HXNetBaseRequest *item in requests) {
            [self _cancelRequest:item];
        }
    });
}

#pragma mark - Override

#pragma mark - Private Method
- (void)_cancelRequest:(HXNetBaseRequest *)request {
    if (!request) {
        return;
    }
    [request.sessionTask cancel];
    [self _removeRecordOfRequest:request];
}

- (void)_requestCompleted:(HXNetBaseRequest *)request error:(NSError *)error urlResponse:(NSURLResponse *)urlResponse responseObject:(id)responseObject {
    
//    if (error) {
//        //TODO:error handle
//        return;
//    }
//
//    NSError *serializationError = nil;
//    AFHTTPResponseSerializer *responseSerializer = [self _responseSerializerForRequest:targetRequest];
//    targetRequest.responseObject = [responseSerializer responseObjectForResponse:urlResponse data:responseObject error:&serializationError];
//
//    if (serializationError) {
//        //TODO:error handle
//        return;
//    }
//
//    NSDictionary *parsedDic = [request parseResponse];
//
//    if (parsedDic[HXNetErrorKey]) {//failure
//
//    }
//
//
//
//    NSError * __autoreleasing validationError = nil;
//
//    NSError *requestError = nil;
//    BOOL succeed = NO;
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
- (AFHTTPRequestSerializer *)_requestSerializerFor:(HXNetBaseRequest *)request {
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    if (request.requestSerializerType == HXNetRequestSerializerType_HTTP) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    requestSerializer.timeoutInterval = request.requestTimeoutInterval;
    if ([HXNetRequestGlobalConfig sharedConfig].userNameForAuthorizationHeaderField && [HXNetRequestGlobalConfig sharedConfig].passwordForAuthorizationHeaderField) {
        [requestSerializer setAuthorizationHeaderFieldWithUsername:[HXNetRequestGlobalConfig sharedConfig].userNameForAuthorizationHeaderField
                                                          password:[HXNetRequestGlobalConfig sharedConfig].passwordForAuthorizationHeaderField];
    }
    
    if ([HXNetRequestGlobalConfig sharedConfig].publicHeader) {
        for (NSString *key in [HXNetRequestGlobalConfig sharedConfig].publicHeader.allKeys) {
            NSString *value = [HXNetRequestGlobalConfig sharedConfig].publicHeader[key];
            [requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    
    if (request.header) {
        for (NSString *key in request.header.allKeys) {
            NSString *value = request.header[key];
            [requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    return requestSerializer;
}

- (AFHTTPResponseSerializer *)_responseSerializerForRequest:(HXNetBaseRequest *)request {
    
    if (request.responseSerializerType == HXNetResponseSerializerType_JSON) {
        AFJSONResponseSerializer *serilizer = [AFJSONResponseSerializer serializer];
        serilizer.removesKeysWithNullValues = request.removesKeysWithNullValues;
        return serilizer;
    }
    return self.sessionManager.responseSerializer;
}

- (NSURLSessionTask *)_sessionTaskForRequest:(HXNetBaseRequest *)request error:(NSError **)error {
    
    NSMutableURLRequest *urlRequest = request.customURLRequest;
    if (!urlRequest) {
        AFHTTPRequestSerializer *requestSerializer = [self _requestSerializerFor:request];
        NSString *urlString = [self _getURLStringFromRequest:request];
        
        urlRequest = [requestSerializer requestWithMethod:request.methodString URLString:urlString parameters:request.parameters error:error];
    }
    
    if (error) {
        return nil;
    }
    
    
    return [self.sessionManager dataTaskWithRequest:urlRequest
             uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
                if (request.uploadProgress) {
                    request.uploadProgress(uploadProgress, @{HXNetRequestKey : request});
                }
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
          
        if (request.downloadProgress) {
            request.downloadProgress(downloadProgress, @{HXNetRequestKey : request});
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self _requestCompleted:request error:error urlResponse:response responseObject:responseObject];
    }];
    
}

- (void)_recordRequest:(HXNetBaseRequest *)request {
    self.requestRecordsDic[@(request.sessionTask.taskIdentifier)] = request;
}

- (void)_removeRecordOfRequest:(HXNetBaseRequest *)request {
    [self.requestRecordsDic removeObjectForKey:@(request.sessionTask.taskIdentifier)];
}

- (NSString *)_getURLStringFromRequest:(HXNetBaseRequest *)request {
    
    if ([request.requestURLString hasPrefix:@"http"]) {
        return request.requestURLString;
    }
    
    NSString *baseURLStr = [HXNetRequestGlobalConfig sharedConfig].baseURLStr;
    NSURL *baseURL = [NSURL URLWithString:baseURLStr];
    
    if (baseURLStr.length > 0 && ![baseURLStr hasSuffix:@"/"]) {
        baseURL = [baseURL URLByAppendingPathComponent:@""];
    }
    
    return [[NSURL URLWithString:request.requestURLString relativeToURL:baseURL] absoluteString];
    
}

#pragma mark - Delegate

#pragma mark - Setter And Getter

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        NSURLSessionConfiguration  *sessionConfiguration = [HXNetRequestGlobalConfig sharedConfig].sessionConfiguration ?: [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    return _sessionManager;
}

- (NSMutableDictionary<NSNumber *,HXNetBaseRequest *> *)requestRecordsDic {
    if (!_requestRecordsDic) {
        _requestRecordsDic = [NSMutableDictionary dictionary];
    }
    return _requestRecordsDic;
}

- (dispatch_queue_t)netSerialQueue {
    if (!_netSerialQueue) {
        _netSerialQueue = dispatch_queue_create("HXNetKit.managerQueue", NULL);
    }
    return _netSerialQueue;
}

- (BOOL)netReachable {
    return self.reachabilityManager.isReachable;
}

- (BOOL)netReachableViaWiFi {
    return self.reachabilityManager.isReachableViaWiFi;
}

- (BOOL)netReachableViaWWAN {
    return self.reachabilityManager.isReachableViaWWAN;
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
