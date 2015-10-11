//
//  SYTabBarViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYTabBarViewController.h"
#import "SYHomeViewController.h"
#import "SYMessageCenterViewController.h"
#import "SYDiscoverViewController.h"
#import "SYProfileViewController.h"
#import "SYNavigationController.h"
@interface SYTabBarViewController ()

@end

@implementation SYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SYHomeViewController *homeVc = [[SYHomeViewController alloc] init];
    [self addchildVc:homeVc title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    SYMessageCenterViewController   *messageVc = [[SYMessageCenterViewController alloc] init];
    [self addchildVc:messageVc title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    SYDiscoverViewController   *discoverVc = [[SYDiscoverViewController alloc] init];
    [self addchildVc:discoverVc title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    SYProfileViewController   *profileVc = [[SYProfileViewController alloc] init];
    [self addchildVc:profileVc title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
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
//    childVc.tabBarItem.title = title;  //底部tabBarItem文字
//    childVc.navigationItem.title = title; //顶部NavigationBarItem的文字
    childVc.title = title; //同时设置两个，等同于上面两项
    
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
    
    
    SYNavigationController *nav = [[SYNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}


@end
