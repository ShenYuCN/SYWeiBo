//
//  SYTextView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/21.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYTextView.h"

@implementation SYTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 不要设置自己的delegate为自己，有新的代理的话会直接顶掉
        //        self.delegate = self;
        
        // 通知
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)textDidChange{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //如果有占位文字直接返回
    if (self.hasText) return;
    //占位文字的区域
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - x * 2;
    CGFloat h = rect.size.height - y *2;
    CGRect placeRect = CGRectMake(x, y, w, h);
    //占位文字的属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = self.placeHolderColor?self.placeHolderColor:[UIColor grayColor];
    dict[NSFontAttributeName] = self.font;
    
    [self.placeHolder drawInRect:placeRect withAttributes:dict];
    
}


-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = [placeHolder copy];
     // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    [self setNeedsDisplay];

}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
    
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

@end
