//
//  ParentRouterHeader.h
//  JamesCreative
//
//  Created by James on 2020/1/21.
//  Copyright © 2020 James. All rights reserved.
//

#ifndef ParentRouterHeader_h
#define ParentRouterHeader_h

#import "HXRouter.h"

static NSString * const RouterNamespace_JamesTestProject = @"JamesTestProject";

static NSString * const RouterURLString_MainServiceName = @"";

//Module_A
static NSString * const RouterURLString_AModule = @"parent://modulea";
//parameters sample: {@"id" : @"333"}

//Module_B
static NSString * const RouterURLString_BModule = @"parent://moduleb";
//parameters sample: {@"id" : @"333"}


#endif /* ParentRouterHeader_h */
