//
//  AppDelegate.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/9.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "AppDelegate.h"
#import "SYHomeViewController.h"
#import "SYMessageCenterViewController.h"
#import "SYDiscoverViewController.h"
#import "SYProfileViewController.h"
@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置根控制器
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    self.window.rootViewController = tabbarVc;
    
    //3.设置子控制器
   
    
    SYHomeViewController *homeVc = [[SYHomeViewController alloc] init];
    [self addchildVc:homeVc title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    SYMessageCenterViewController   *messageVc = [[SYMessageCenterViewController alloc] init];
    [self addchildVc:messageVc title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];

    SYDiscoverViewController   *discoverVc = [[SYDiscoverViewController alloc] init];
    [self addchildVc:discoverVc title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    SYProfileViewController   *profileVc = [[SYProfileViewController alloc] init];
    [self addchildVc:profileVc title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    tabbarVc.viewControllers = @[homeVc,messageVc,discoverVc,profileVc];
    
    //4.显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
-(void)addchildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    //设置子控制器的TabBarItem的文字和图片
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1];
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    childVc.view.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256)/255.0) green:(arc4random_uniform(256)/255.0) blue:(arc4random_uniform(256)/255.0) alpha:1.0];

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
