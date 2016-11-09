//
//  UIWindow+Extension.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/14.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "SYTabBarViewController.h"
#import "SYNewFeatureViewController.h"

@implementation UIWindow (Extension)
-(void)switchRootViewController{
    
    // 之前已经登录成功过，沙盒中存在数据
    //判断版本是否更新
    NSString *key = @"CFBundleVersion";
    //获得上次运行的版本号，沙盒中获取
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //获得当前软件的版本号（info.plist）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController =  [[SYTabBarViewController alloc] init];
    }else{
        //新特性界面
        self.rootViewController =  [[SYNewFeatureViewController alloc] init];
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
