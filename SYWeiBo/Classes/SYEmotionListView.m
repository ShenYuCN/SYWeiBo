//
//  SYEmotionListView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/22.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionListView.h"
#import "UIView+Extension.h"
#import "SYEmotionPageView.h"


// RGB颜色
#define SYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define SYRandomColor SYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface SYEmotionListView()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;

@end
@implementation SYEmotionListView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor redColor];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //PageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        pageControl.backgroundColor = [UIColor purpleColor];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return  self;
}
-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    NSUInteger count = (emotions.count + kSYEmotionPageSize - 1) / kSYEmotionPageSize;
    
    // 1.设置页数
    self.pageControl.numberOfPages = count;
    
    //2.创建每一页用来显示表情的控件
    for (int i = 0; i < count; i++) {
        SYEmotionPageView *pageView = [[SYEmotionPageView alloc] init];
        NSRange range;
        NSUInteger leftEmotionsCount = emotions.count - i * kSYEmotionPageSize;
        range.location = i * kSYEmotionPageSize;
        range.length = leftEmotionsCount > kSYEmotionPageSize ? kSYEmotionPageSize : leftEmotionsCount;
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    
}

-(void)layoutSubviews{

    self.pageControl.x = 0;
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    //设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    NSLog(@"scrollView.count %zd",count);
    
    for (int i = 0; i < count; i++) {
        SYEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = i * pageView.width;
        pageView.y = 0;
    }
    
    //设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

#pragma mark - UIScrollViewDelegate 代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double  pageNum =  self.scrollView.contentOffset.x / self.scrollView.width;
    self.pageControl.currentPage =  (int)(pageNum + 0.5);
}
@end
