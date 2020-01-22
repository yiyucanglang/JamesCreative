//
//  HXEasyRequestBasicDefine.h
//  JamesCreative
//
//  Created by James on 2019/11/21.
//  Copyright © 2019 James. All rights reserved.
//

#ifndef HXEasyRequestBasicDefine_h
#define HXEasyRequestBasicDefine_h

typedef NS_ENUM(NSInteger, HXEasyRequestMethodType) {
    HXEasyRequestMethodType_POST,
    HXEasyRequestMethodType_GET,
    HXEasyRequestMethodType_HEAD,
    HXEasyRequestMethodType_DELETE,
    HXEasyRequestMethodType_PUT,
    HXEasyRequestMethodType_PATCH,
};

typedef NS_ENUM(NSInteger, HXEasyRequestSerializerType) {
    HXEasyRequestSerializerType_JSON,
    HXEasyRequestSerializerType_HTTP,
};


typedef NS_ENUM(NSInteger, HXEasyResponseSerializerType) {
    HXEasyResponseSerializerType_JSON,
    HXEasyResponseSerializerType_HTTP,
    HXEasyResponseSerializerType_XML,
};


@protocol HXEasyRequestDelegate <NSObject>


@end

#endif /* HXEasyRequestBasicDefine_h */
