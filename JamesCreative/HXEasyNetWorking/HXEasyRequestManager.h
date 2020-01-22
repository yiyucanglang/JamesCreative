//
//  HXEasyRequestManager.h
//  JamesCreative
//
//  Created by James on 2019/11/21.
//  Copyright © 2019 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXEasyRequest;
NS_ASSUME_NONNULL_BEGIN

@interface HXEasyRequestManager : NSObject

+ (instancetype)sharedManager;

- (void)sendRequest:(HXEasyRequest *)request;

- (void)cancelRequest:(HXEasyRequest *)request;

- (void)cancelRequests:(NSArray<HXEasyRequest *> *)requests;

- (void)cancelAllRequests;

@end

NS_ASSUME_NONNULL_END
