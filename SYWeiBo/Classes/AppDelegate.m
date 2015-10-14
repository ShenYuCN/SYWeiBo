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
#import "SYAccount.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置根控制器
    
    //沙盒路径
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [document stringByAppendingPathComponent:@"account.archive"];
    SYAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if (account) {
        // 之前已经登录成功过，沙盒中存在数据
        //判断版本是否更新
        NSString *key = @"CFBundleVersion";
        //获得上次运行的版本号，沙盒中获取
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        //获得当前软件的版本号（info.plist）
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        if ([currentVersion isEqualToString:lastVersion]) {
            self.window.rootViewController =  [[SYTabBarViewController alloc] init];
        }else{
            //新特性界面
            self.window.rootViewController =  [[SYNewFeatureViewController alloc] init];
             // 将当前的版本号存进沙盒
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
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
