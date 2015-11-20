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
#import "NSString+File.h"
#import "SDImageCache.h"
@interface Test1ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UITextField *size;
@end

@implementation Test1ViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSString *path = [[SDImageCache sharedImageCache] diskCachePath];
    NSLog(@"%@",path);
    long long size = [path fileSize];
    self.sizeLabel.text = [NSString stringWithFormat:@"%.1fM",size / (1000.0 * 1000.0)] ;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *path = [[SDImageCache sharedImageCache] diskCachePath];
    [mgr removeItemAtPath:path error:nil];
}

@end
