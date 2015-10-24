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
#import "SYEmotionPopView.h"
#import "SYEmotionButton.h"

// 随机色
#define SYRandomColor [UIColor colorWithRed:(arc4random_uniform(256))/255.0 green:(arc4random_uniform(256))/255.0 blue:(arc4random_uniform(256))/255.0 alpha:1.0]
@interface SYEmotionPageView()
@property(nonatomic,strong) SYEmotionPopView *popView;
@end


@implementation SYEmotionPageView
-(SYEmotionPopView *)popView{
    if (_popView == nil) {
        self.popView = [SYEmotionPopView popView];
    }
    return _popView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = SYRandomColor;
    }
    return self;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    for (int i = 0; i < emotions.count ; i++) {
        SYEmotionButton *btn = [[SYEmotionButton alloc] init];
        btn.emotion = emotions[i];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
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
        SYEmotionButton *btn = self.subviews[i];
        btn.x = inset + btnW * (i % kSYEmotionMaxCols);
        btn.y = inset + btnH * (i / kSYEmotionMaxCols);
        btn.width = btnW;
        btn.height = btnH;
    }
}
-(void)buttonClick:(SYEmotionButton *)btn{
    
    self.popView.emotion = btn.emotion;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];

    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    
    self.popView.centerX = CGRectGetMidX(btnFrame);
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
   }
@end
