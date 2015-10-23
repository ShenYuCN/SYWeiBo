//
//  SYEmotionListView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/22.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionListView.h"
#import "UIView+Extension.h"

#define kSYEmotionPageSize 20
@interface SYEmotionListView()
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
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //PageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        pageControl.backgroundColor = [UIColor purpleColor];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
//        pageControl.numberOfPages = 4;
        
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
}
@end
