//
//  SYHomeViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "SYDropdownMenu.h"
#import "SYTitleMenuViewController.h"
@interface SYHomeViewController ()
@end

@implementation SYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏左右按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    //导航栏中间
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.height = 30;
    titleBtn.width = 200;
    
    //设置图片和文字
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    
    self.navigationItem.titleView = titleBtn;
    
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)titleClick:(UIButton *)titleButton{
    //创建一个下拉菜单
    SYDropdownMenu *menu = [SYDropdownMenu menu];
    
    SYTitleMenuViewController *vc = [[SYTitleMenuViewController alloc] init];
    vc.view.height = 44 * 3;
    vc.view.width = 150;
    menu.contentController = vc;
    
    //显示
    [menu showFrom:titleButton];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

-(void)back{
    NSLog(@"back");
}

-(void)more{
    NSLog(@"more");
}
@end
