//
//  SYEmotionTabBarButton.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/22.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionTabBarButton.h"

@implementation SYEmotionTabBarButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted{
//    无选中高亮效果
//    按钮高亮所做的一切操作都不在了.主要是为了按钮按下去,要立马变颜色
}

@end
