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

@interface SYEmotionKeyBoard()<SYEmotionTabBarDelegate>
/** tabBar */
@property(nonatomic,weak) SYEmotionTabBar *tabBar;
/** 表情内容 */
@property (nonatomic,weak) SYEmotionListView *listView;
@end
@implementation SYEmotionKeyBoard

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"init key board");
        SYEmotionTabBar *tabBar = [[SYEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        SYEmotionListView *listView = [[SYEmotionListView alloc] init];
        [self addSubview:listView];
        listView.backgroundColor = [UIColor redColor];
        self.listView = listView;
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
    
    //listView 的frame
    self.listView.x = 0;
    self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabBar.y;
}

#pragma mark - SYEmotionTabBarDelegate
-(void)emotionTabBar:(SYEmotionTabBar *)emotionTabBar didSelectedButton:(SYEmotionTabBarButtonType)buttonType{
    switch (buttonType) {
        case SYEmotionTabBarButtonTypeRecent: // 最近
            NSLog(@"最近");
            break;
            
        case SYEmotionTabBarButtonTypeDefault: // 默认
            NSLog(@"默认");
            break;
            
        case SYEmotionTabBarButtonTypeEmoji: // Emoji
            NSLog(@"Emoji");
            break;
            
        case SYEmotionTabBarButtonTypeLxh: // Lxh
            NSLog(@"Lxh");
            break;
    }

}

@end
