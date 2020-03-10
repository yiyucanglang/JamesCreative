 //
//  HXEasyRequestResponse.h
//  JamesCreative
//
//  Created by James on 2019/11/21.
//  Copyright © 2019 James. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXEasyRequestResponse : NSObject
@property (nonatomic, strong, readonly, nullable) id  requestProcessedResponse;
@property (nonatomic, strong, readonly, nullable) NSError *error;

@property (nonatomic, strong, readonly, nullable) NSURLResponse  *originalURLResponse;
@property (nonatomic, strong, readonly, nullable) id  originalResponseObject;
@end

NS_ASSUME_NONNULL_END
