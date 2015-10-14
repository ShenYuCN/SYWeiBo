//
//  AppDelegate.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/9.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "AppDelegate.h"
#import "SYTabBarViewController.h"
#import "SYNewFeatureViewController.h"
#import "SYOAuthViewController.h"
#import "SYAccountTool.h"
#import "SYAccount.h"
#import "UIWindow+Extension.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置根控制器
    //取出账号信息
     SYAccount *account = [SYAccountTool account];
    if (account) {
        [self.window switchRootViewController];
    }else{
        //如果沙盒中不存在数据，说明没有登录过，进入登录界面
        self.window.rootViewController =  [[SYOAuthViewController alloc] init];
    }
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
