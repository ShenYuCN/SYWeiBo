//
//  SYEmotionTabBar.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/22.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    SYEmotionTabBarButtonTypeRecent, // 最近
    SYEmotionTabBarButtonTypeDefault, // 默认
    SYEmotionTabBarButtonTypeEmoji, // emoji
    SYEmotionTabBarButtonTypeLxh, // 浪小花
} SYEmotionTabBarButtonType;
@class SYEmotionTabBar;
@protocol SYEmotionTabBarDelegate <NSObject>
@optional
-(void)emotionTabBar:(SYEmotionTabBar *)emotionTabBar didSelectedButton:(SYEmotionTabBarButtonType)buttonType;

@end

@interface SYEmotionTabBar : UIView
@property (nonatomic,weak) id<SYEmotionTabBarDelegate>  delegate;
@end
