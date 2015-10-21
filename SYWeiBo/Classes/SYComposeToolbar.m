//
//  SYComposeToolbar.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/21.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYComposeToolbar.h"
#import "UIView+Extension.h"

@implementation SYComposeToolbar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        // 初始化按钮
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:SYComposeToolbarButtonTypeCamera ];
        
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:SYComposeToolbarButtonTypePicture];
        
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:SYComposeToolbarButtonTypeMention];
        
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:SYComposeToolbarButtonTypeTrend ];
        
        [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:SYComposeToolbarButtonTypeEmotion];
    }
    return self;
}
-(void)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(SYComposeToolbarButtonType)type{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.tag = type;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

-(void)layoutSubviews{

    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0 ; i < count; i ++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
}
-(void)btnClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(compostToolBar:didClickButton:)]) {
        [self.delegate compostToolBar:self didClickButton:button.tag];
    }
}
@end
