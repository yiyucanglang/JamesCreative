//
//  HXNetKitUtility.m
//  JamesCreative
//
//  Created by 周义进 on 2020/2/28.
//  Copyright © 2020 James. All rights reserved.
//

#import "HXNetKitUtility.h"

NSString* requestMethodString(HXNetRequestMethodType methodType) {
    switch (methodType) {
        case HXNetRequestMethodType_POST:
            return HXNetRequestMethodString_POST;
            break;
            
        case HXNetRequestMethodType_GET:
            return HXNetRequestMethodString_GET;
            break;
            
        case HXNetRequestMethodType_HEAD:
            return HXNetRequestMethodString_HEAD;
            break;
            
        case HXNetRequestMethodType_DELETE:
            return HXNetRequestMethodString_DELETE;
            break;
            
        case HXNetRequestMethodType_PUT:
            return HXNetRequestMethodString_PUT;
            break;
         
        case HXNetRequestMethodType_PATCH:
            return HXNetRequestMethodString_PATCH;
            break;
            
        default:
            return HXNetRequestMethodString_POST;
            break;
    }
}

void HXNetAsyncRun(HXNetRun run) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        run();
    });
}
void HXNetAsyncRunInMain(HXNetRun run) {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        run();
    });
}
void HXNetAsynRunInQueue(dispatch_queue_t queue, HXNetRun run) {
    dispatch_async(queue, ^(void) {
        run();
    });
}

void HXNetSynRunInQueue(dispatch_queue_t queue, HXNetRun run) {
    dispatch_sync(queue, ^(void) {
        run();
    });
}
