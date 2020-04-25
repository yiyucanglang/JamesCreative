//
//  AppDelegate.m
//  JamesCreative
//
//  Created by James on 2019/11/20.
//  Copyright © 2019 James. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"didFinishLaunchingWithOptions");
    [UIApplication sharedApplication].statusBarHidden = YES;
//    application.statusBarHidden = YES;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [self.window makeKeyAndVisible];
//    [ONLDynamicLoader executeFunctionsForKey:LEVEL_A];
    
    return YES;
}



@end
