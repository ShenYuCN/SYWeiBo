//
//  Test1ViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "Test1ViewController.h"
#import "UIView+Extension.h"
#import "SYProfileViewController.h"
#import "Test2ViewController.h"
@interface Test1ViewController ()

@end

@implementation Test1ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//    backBtn.size = backBtn.currentBackgroundImage.size;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
//    moreBtn.size = moreBtn.currentBackgroundImage.size;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
//    
//    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
//}
//-(void)back{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//-(void)more{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SYProfileViewController *mie = [[SYProfileViewController alloc] init];
//    [self.navigationController pushViewController:mie animated:YES];
    
    Test2ViewController *test2 = [[Test2ViewController alloc] init];
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
