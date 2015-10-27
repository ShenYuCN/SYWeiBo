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
#import "SYEmotionTool.h"
#import "SYConst.h"

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
        
        
        //添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}
/**
 *  根据手指位置所在的表情按钮
 */
-(SYEmotionButton *)emotionButtonWithLocation:(CGPoint)location{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        SYEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
        }
    }
    return nil;
}
/**
 *  长按手势的监听
 */
-(void)longPressPageView:(UILongPressGestureRecognizer *)recognizer{
    
    CGPoint location = [recognizer locationInView:recognizer.view];
    SYEmotionButton *btn = [self emotionButtonWithLocation:location];
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{//手指不在触摸pageView
            
            [self.popView removeFromSuperview];
            //如果手指还在按钮上
            if (btn) {
                //这一句也可以，不严谨，还显示一次popView
                // [self buttonClick:btn];
                
                //发出通知
                [self selectEmotion:btn];
            }
            break;
        }
        case UIGestureRecognizerStateBegan://开始触摸
        case UIGestureRecognizerStateChanged:{//手指位置改变
            [self.popView showFrom:btn];
            break;
        }
        default:
            break;
    }
    
    
}
-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    for (int i = 0; i < emotions.count ; i++) {
        SYEmotionButton *btn = [[SYEmotionButton alloc] init];
        
        //设置表情数据
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
    
    //显示popView
    [self.popView showFrom:btn];
    
    //过一会popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    //发出通知
    [self selectEmotion:btn];
    
}
/**
 *  选中表情，发出通知
 *
 *  @param emotion 选中表情的emotion属性
 */
-(void)selectEmotion:(SYEmotionButton *)btn{
    
    //添加到沙盒
    [SYEmotionTool addRecentEmotion:btn.emotion];
    
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[SYSelectEmotionKey] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:SYEmotionDidSelectNotification object:nil userInfo:userInfo];
    
}
/**
 *  删除按钮的点击事件
 */
-(void)deleteClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:SYEmotionDidDeleteNotification object:nil];
}
@end
