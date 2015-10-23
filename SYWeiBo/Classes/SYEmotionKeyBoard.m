//
//  SYEmotionKeyBoard.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/22.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionKeyBoard.h"
#import "SYEmotionTabBar.h"
#import "SYEmotionListView.h"
#import "UIView+Extension.h"
#import "SYEmotion.h"
#import "MJExtension.h"
// RGB颜色
#define SYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define SYRandomColor SYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))



@interface SYEmotionKeyBoard()<SYEmotionTabBarDelegate>
/** tabBar */
@property(nonatomic,weak) SYEmotionTabBar *tabBar;
/** 容纳表情内容的容器 */
@property (nonatomic,strong) UIView *contentView;

/** EmotionListView-最近 */
@property (nonatomic,strong) SYEmotionListView *recentListView;
/** EmotionListView-默认 */
@property (nonatomic,strong) SYEmotionListView *defaultListView;
/** EmotionListView-emoji */
@property (nonatomic,strong) SYEmotionListView *emojiListView;
/** EmotionListView-浪小花 */
@property (nonatomic,strong) SYEmotionListView *lxhListView;

@end

@implementation SYEmotionKeyBoard


#pragma mark - 懒加载
-(SYEmotionListView *)recentListView{
    if (_recentListView == nil) {
        self.recentListView = [[SYEmotionListView alloc] init];
    }
    return _recentListView;
}
-(SYEmotionListView *)defaultListView{
    if (_defaultListView == nil) {
      
        self.defaultListView = [[SYEmotionListView alloc] init];;
     
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        //表情字典数组  转成 模型数组
        self.defaultListView.emotions = [SYEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        //TODO: 设置背景色直接返回，有问题
        self.defaultListView.backgroundColor = [UIColor redColor];
        NSLog(@"defaultListView");
       
    }
    return _defaultListView;
}
-(SYEmotionListView *)emojiListView{
    if (_emojiListView == nil) {
        self.emojiListView = [[SYEmotionListView alloc] init];;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        //表情字典数组  转成 模型数组
        self.defaultListView.emotions = [SYEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.emojiListView.backgroundColor = SYRandomColor;
        NSLog(@"emojiListView");
    }
    return _emojiListView;
}
-(SYEmotionListView *)lxhListView{
    if (_lxhListView == nil) {
        self.lxhListView = [[SYEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        //表情字典数组  转成 模型数组
        self.defaultListView.emotions = [SYEmotion objectArrayWithKeyValuesArray: [NSArray arrayWithContentsOfFile:path]];
        self.lxhListView.backgroundColor = SYRandomColor;
    }
    return _lxhListView;
}

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         //!!!:  这里必须先初始化 父容器，如果先初始化子控件会有莫名其妙的未知问题
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        SYEmotionTabBar *tabBar = [[SYEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //tabBar 的Frame
    self.tabBar.x = 0;
    self.tabBar.height = 37;
    self.tabBar.width = self.width;
    self.tabBar.y = self.height - self.tabBar.height;
    
    //contentView 的frame
    self.contentView.x = 0;
    self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabBar.y;
    
    //设置 contentView 的子控件（表情内容）的frame
    UIView *childView = [self.contentView.subviews lastObject];
    childView.frame = self.contentView.frame;
    
}

#pragma mark - SYEmotionTabBarDelegate
-(void)emotionTabBar:(SYEmotionTabBar *)emotionTabBar didSelectedButton:(SYEmotionTabBarButtonType)buttonType{
    // 移除contentView之前显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (buttonType) {
        case SYEmotionTabBarButtonTypeRecent: // 最近
            [self.contentView addSubview:self.recentListView];
            NSLog(@"最近");
            break;
            
        case SYEmotionTabBarButtonTypeDefault: // 默认
            [self.contentView addSubview:self.defaultListView];
            break;
            
        case SYEmotionTabBarButtonTypeEmoji: // Emoji
            [self.contentView addSubview:self.emojiListView];
            break;
            
        case SYEmotionTabBarButtonTypeLxh: // Lxh
            [self.contentView addSubview:self.lxhListView];
            break;
    }
    
    // 重新计算子控件的frame(setNeedsLayout内部会在恰当的时刻，重新调用layoutSubviews，重新布局子控件)
    //UIView *child = [self.contentView.subviews lastObject];
    //child.frame = self.contentView.bounds;
    [self setNeedsLayout];

}

@end
