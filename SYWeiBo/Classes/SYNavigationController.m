//
//  SYNavigationController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/11.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYNavigationController.h"
#import "UIView+Extension.h"
@interface SYNavigationController ()

@end

@implementation SYNavigationController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"count %d--- %@",self.childViewControllers.count,viewController);
    if (self.childViewControllers.count > 0) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        backBtn.size = backBtn.currentBackgroundImage.size;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        moreBtn.size = moreBtn.currentBackgroundImage.size;
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
        
        [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];

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
