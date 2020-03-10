//
//  HXEasyRequestGlobalConfig.h
//  JamesCreative
//
//  Created by James on 2019/11/21.
//  Copyright © 2019 James. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXEasyRequestGlobalConfig : NSObject
@property (nonatomic, strong, nullable) NSMutableDictionary  *globalRequestHeader;
@property (nonatomic, strong, nullable) NSMutableDictionary  *globalRequestParameters;
@property (nonatomic, strong, nullable) NSString  *baseURLStr;
@property (nonatomic, strong, nullable) NSURLSessionConfiguration  *sessionConfiguration;
@property (nonatomic, copy, nullable) NSString  *userNameForAuthorizationHeaderField;
@property (nonatomic, copy, nullable) NSString  *passwordForAuthorizationHeaderField;


/// Default: 15s
@property (nonatomic, assign) NSTimeInterval   requestTimeoutInterval;


+ (instancetype)sharedConfig;

@end

NS_ASSUME_NONNULL_END
