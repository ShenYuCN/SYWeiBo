//
//  SYNewFeatureViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/13.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYNewFeatureViewController.h"
#import "UIView+Extension.h"

#define kSYNewfeatureCount 4
@interface SYNewFeatureViewController()<UIScrollViewDelegate>
@property(nonatomic,strong) UIPageControl *pageControl;
@end
@implementation SYNewFeatureViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    //1、创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    
    //2、添加图片
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < kSYNewfeatureCount ; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        
        imageView.height = scrollH;
        imageView.width = scrollW;
        imageView.y = 0;
        imageView.x = i * scrollView.width;
        [scrollView addSubview:imageView];
    }
    //3、设置ScrollView的其他属性
    scrollView.contentSize = CGSizeMake(kSYNewfeatureCount * scrollW, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //4、添加分页，UIPageControl 即使没有设置宽高也正在显示，它本身是0 . 0 没有大小，不可点击，但是子控件有
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = kSYNewfeatureCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height - 50;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
  }
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSLog(@"%f",scrollView.contentOffset.x / self.view.width);
    double pageNum = scrollView.contentOffset.x / self.view.width;
    self.pageControl.currentPage = (int)(pageNum + 0.5);
}
@end
