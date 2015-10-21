//
//  SYComposeViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/20.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYComposeViewController.h"
#import "SYAccountTool.h"
#import "UIView+Extension.h"
@interface SYComposeViewController ()

@end

@implementation SYComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    [self setupNav];

}
/**
 *  设置导航栏
 */
-(void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.height = 60;
    titleLabel.width = 200;
//    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    
    NSString *prefix = @"发微博";
    NSString *name = [SYAccountTool account].name;
    NSString *newStr= [NSString stringWithFormat:@"%@\n%@",prefix,name];
    
    //创建一个带属性的字符串
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:newStr];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[newStr rangeOfString:prefix]];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[newStr rangeOfString:name]];
    
    titleLabel.attributedText = attrStr;
    self.navigationItem.titleView = titleLabel;
    

}


-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)send{
    NSLog(@"send");
}

@end
