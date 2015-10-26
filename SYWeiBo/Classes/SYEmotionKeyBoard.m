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

@interface SYEmotionKeyBoard()<SYEmotionTabBarDelegate>
/** tabBar */
@property(nonatomic,weak) SYEmotionTabBar *tabBar;

/** 保存正在显示的listView */
@property (nonatomic,strong) SYEmotionListView *showingListView;

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
        //TODO: 设置背景色直接返回，必须将容器先初始化，再初始化子控件
        //self.defaultListView.backgroundColor = [UIColor redColor];
        
    }
    return _defaultListView;
}
-(SYEmotionListView *)emojiListView{
    if (_emojiListView == nil) {
        self.emojiListView = [[SYEmotionListView alloc] init];;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [SYEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}
-(SYEmotionListView *)lxhListView{
    if (_lxhListView == nil) {
        self.lxhListView = [[SYEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [SYEmotion objectArrayWithKeyValuesArray: [NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
         //!!!:  这里必须先初始化 父容器，如果先初始化子控件会有莫名其妙的未知问题
         // UIView *contentView = [[UIView alloc] init];
         //[self addSubview:contentView];
         //self.contentView = contentView;
        
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
    self.showingListView.x = 0;
    self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
    
//    //设置 contentView 的子控件（表情内容）的frame
//    UIView *childView = [self.subviews lastObject];
//    childView.frame = self.frame;
    
}

#pragma mark - SYEmotionTabBarDelegate
-(void)emotionTabBar:(SYEmotionTabBar *)emotionTabBar didSelectedButton:(SYEmotionTabBarButtonType)buttonType{
    
    // 移除正在显示的listView
    [self.showingListView removeFromSuperview];
    
    switch (buttonType) {
        case SYEmotionTabBarButtonTypeRecent: // 最近
            [self addSubview:self.recentListView];
            break;
            
        case SYEmotionTabBarButtonTypeDefault: // 默认
            [self addSubview:self.defaultListView];
            break;
            
        case SYEmotionTabBarButtonTypeEmoji: // Emoji
            [self addSubview:self.emojiListView];
            break;
            
        case SYEmotionTabBarButtonTypeLxh: // Lxh
            [self addSubview:self.lxhListView];
            // self.showingListView = self.lxhListView;
            break;
    }
    
    // 设置正在显示的listView,将上面四步封装
    self.showingListView = [self.subviews lastObject];
    //设置frame
    [self setNeedsLayout];

}

@end
