//
//  SYNavigationController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/11.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYNavigationController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
@interface SYNavigationController ()

@end

@implementation SYNavigationController

+(void)initialize{

    //设置整个项目的UIBarButtonItem的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //正常状态
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    //不可用状态
    NSMutableDictionary *disableTextAttr = [NSMutableDictionary dictionary];
    disableTextAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableTextAttr[NSFontAttributeName] = textAttr[NSFontAttributeName];
    [item setTitleTextAttributes:disableTextAttr forState:UIControlStateDisabled];

    
    
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
}
/**tui
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        
        //左边的barButtonItem
         viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted"];
        
        //右边的barButtonItem
        viewController.navigationItem.rightBarButtonItem =  [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted"];

    }
    [super pushViewController:viewController animated:YES];
}
-(void)back{
    //这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

-(void)more{
    [self popToRootViewControllerAnimated:YES];
}
@end
