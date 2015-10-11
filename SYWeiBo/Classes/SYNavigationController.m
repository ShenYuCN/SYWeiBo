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
    [self popViewControllerAnimated:YES];
}

-(void)more{
    [self popToRootViewControllerAnimated:YES];
}
@end
