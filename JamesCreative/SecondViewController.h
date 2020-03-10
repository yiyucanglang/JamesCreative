//
//  SecondViewController.h
//  JamesCreative
//
//  Created by James on 2019/11/27.
//  Copyright © 2019 James. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kImagePath(bundle, imageName, type, directoryName) [bundle pathForResource:[NSString stringWithFormat:@"%@@%@x", imageName, @([UIScreen mainScreen].scale)] ofType:type inDirectory:directoryName]

#define kimage(bundle, imageName, type, directoryName) [UIImage imageWithContentsOfFile:kImagePath(bundle, imageName, type, directoryName)]

static NSString const *a_query_name = @"name";
static NSString const *a_query_age  = @"age";
static NSString const *a_moduleURL  = @"james://message?name=111&age=12";

static NSString *test = @"test";

@interface SecondViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
