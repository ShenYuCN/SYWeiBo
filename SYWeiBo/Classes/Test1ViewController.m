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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    Test2ViewController *test2 = [[Test2ViewController alloc] init];
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
