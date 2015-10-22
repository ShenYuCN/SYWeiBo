//
//  SYEmotionTabBar.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/22.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionTabBar.h"
#import "UIView+Extension.h"
#import "SYEmotionTabBarButton.h"
@interface SYEmotionTabBar()
@property(nonatomic,strong) SYEmotionTabBarButton *selectedBtn;
@end

@implementation SYEmotionTabBar

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setupBtn:@"最近" buttonType:SYEmotionTabBarButtonTypeRecent ];
        [self setupBtn:@"默认" buttonType:SYEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:SYEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:SYEmotionTabBarButtonTypeLxh];
    }
    return self;
}
-(SYEmotionTabBarButton *)setupBtn:(NSString *) title buttonType:(SYEmotionTabBarButtonType) buttonType{
    SYEmotionTabBarButton *btn = [[SYEmotionTabBarButton alloc] init];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [self addSubview:btn];
    
    //设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    if (buttonType == SYEmotionTabBarButtonTypeDefault) {
        [self buttonClick:btn];
    }
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btnW;
        btn.y = 0;
    }
    
}
-(void)buttonClick:(SYEmotionTabBarButton *)btn{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectedButton:)]){
        [self.delegate emotionTabBar:self didSelectedButton:btn.tag];
    }
    
}
@end
