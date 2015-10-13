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
        
        if (i == kSYNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
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


-(void)setupLastImageView:(UIImageView *)imageView{
    
    imageView.userInteractionEnabled = YES;
    // 1.分享给大家（checkbox）
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //注意长和宽必须在x,y值之前设置
    shareBtn.height = 30;
    shareBtn.width = 200;
    shareBtn.centerX = imageView.width  * 0.5;
    shareBtn.centerY = imageView.height * 0.6;
    
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
   
    //2.开始微博

    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = imageView.width * 0.5;
    startBtn.centerY = imageView.height * 0.7;
    
    [imageView addSubview:startBtn];
}

-(void)shareClick:(UIButton *)shareButton{

    shareButton.selected = !shareButton.isSelected;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageNum = scrollView.contentOffset.x / self.view.width;
    self.pageControl.currentPage = (int)(pageNum + 0.5);
}
@end
