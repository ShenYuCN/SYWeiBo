//
//  SYTabBar.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/12.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYTabBar.h"
#import "UIView+Extension.h"
@interface SYTabBar()
@property(nonatomic,weak) UIButton *plusBtn;
@end

@implementation SYTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //添加中间的加号
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;

        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
        
    }
    return self;
}
/**
 *  中间加号的点击事件
 */
-(void)plusClick{
    //通知代理
    if ([self.delegeta respondsToSelector:@selector(tabBarDidClickPlusBtn:)]) {
        [self.delegeta tabBarDidClickPlusBtn:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    
    // 2.设置其他tabbarButton的位置和尺寸
    int index = 0;
    CGFloat tabBarButtonW = self.width / 5;
    Class class = NSClassFromString(@"UITabBarButton");
    
    for (UIView *child in self.subviews) {
        if ([child isKindOfClass:class]) {
            child.width = tabBarButtonW;
            child.x = index * tabBarButtonW;
            index ++;
            if (index == 2) {
                index ++;
            }
        }
        
    }
}
@end
