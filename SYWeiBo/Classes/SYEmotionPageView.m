//
//  SYEmotionPageView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/24.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionPageView.h"
#import "SYEmotion.h"
#import "UIView+Extension.h"
#import "NSString+Emoji.h"

// 随机色
#define SYRandomColor [UIColor colorWithRed:(arc4random_uniform(256))/255.0 green:(arc4random_uniform(256))/255.0 blue:(arc4random_uniform(256))/255.0 alpha:1.0]
@implementation SYEmotionPageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = SYRandomColor;
    }
    return self;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    for (int i = 0; i < emotions.count ; i++) {
        UIButton *btn = [[UIButton alloc] init];
        SYEmotion *emotion = emotions[i];
        if (emotion.png) { //有png图片
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        } else if (emotion.code){ //emoji 表情
            [btn setTitle:[emotion.code emoji] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }
        [self addSubview:btn];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.emotions.count;
    CGFloat inset = 10;
    CGFloat btnW = (self.width - 2 *inset) / kSYEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / kSYEmotionMaxRows;
    for (int i = 0 ; i < count; i ++ ) {
        UIButton *btn = self.subviews[i];
        btn.x = inset + btnW * (i % kSYEmotionMaxCols);
        btn.y = inset + btnH * (i / kSYEmotionMaxCols);
        btn.width = btnW;
        btn.height = btnH;
    }
}
@end
