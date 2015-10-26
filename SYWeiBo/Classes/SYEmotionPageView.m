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
@property (nonatomic,strong) UIButton *deleteBtn;
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
        //添加删除按钮
        UIButton *deleteBtn = [[UIButton alloc] init];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn = deleteBtn;
        [self addSubview:deleteBtn];
        
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
    
    //设置每个表情按钮的frame
    NSUInteger count = self.emotions.count;
    CGFloat inset = 10;
    CGFloat btnW = (self.width - 2 *inset) / kSYEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / kSYEmotionMaxRows;
    for (int i = 0 ; i < count; i ++ ) {
        SYEmotionButton *btn = self.subviews[i + 1];
        btn.x = inset + btnW * (i % kSYEmotionMaxCols);
        btn.y = inset + btnH * (i / kSYEmotionMaxCols);
        btn.width = btnW;
        btn.height = btnH;
    }
    
    //设置删除按钮的frame
    self.deleteBtn.x = self.width - inset - btnW;
    self.deleteBtn.y = self.height - btnH;
    self.deleteBtn.height = btnH;
    self.deleteBtn.width = btnW;
    
}

/**
 *  每一个表情的点击事件
 */
-(void)buttonClick:(SYEmotionButton *)btn{
    
    //给popView传递模型数据
    self.popView.emotion = btn.emotion;
    
    //将popView添加到最上面的window上面
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];

    //设置popView的位置
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    self.popView.centerX = CGRectGetMidX(btnFrame);
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    
    //过一会popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"SYSelectEmotionKey"] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SYEmotionDidSelectNotification" object:nil userInfo:userInfo];
    
}
/**
 *  删除按钮的点击事件
 */
-(void)deleteClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SYEmotionDidDelete" object:nil];
}
@end
