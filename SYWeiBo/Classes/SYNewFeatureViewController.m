//
//  SYNewFeatureViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/13.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYNewFeatureViewController.h"
#import "UIView+Extension.h"

@implementation SYNewFeatureViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    //1、创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(4 * scrollView.width, 0);
    [self.view addSubview:scrollView];
    
    //2、添加图片
    for (int i = 0; i < 4 ; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.size = scrollView.size;
        imageView.y = 0;
        imageView.x = i * scrollView.width;
        [scrollView addSubview:imageView];
    }
}
@end
