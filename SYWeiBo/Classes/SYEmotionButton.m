//
//  SYEmotionButton.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/24.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotion.h"
#import "SYEmotionButton.h"
#import "NSString+Emoji.h"

@implementation SYEmotionButton
/**
 *  代码创建时，就会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

/**
 *  初始化一些共同的属性，比如字体大小，高亮状态隐藏
 */
- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    //按钮高亮的时候图片不要变灰
    self.adjustsImageWhenHighlighted = NO;
}

/**
 *  这个方法在initWithCoder:方法后调用
 */
- (void)awakeFromNib
{
    
}
-(void)setEmotion:(SYEmotion *)emotion{
    _emotion = emotion;
    if (emotion.png) { //有png图片
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code){ //emoji 表情
        [self setTitle:[emotion.code emoji] forState:UIControlStateNormal];
//        self.titleLabel.font = [UIFont systemFontOfSize:32];
    }
}

@end
