//
//  SYEmotionTextView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/25.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionTextView.h"
#import "UITextView+Extension.h"
#import "NSString+Emoji.h"

@implementation SYEmotionTextView
-(void)insertEmotion:(SYEmotion *)emotion{
    if (emotion.code) {
        // insertText : 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
    }else if (emotion.png){
 
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:emotion.png];
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        
        [self insertAttributeText:imageStr];
        
        
        // 设置字体
//        NSMutableAttributedString *text = (NSMutableAttributedString *)self.attributedText;
//        [text addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
        
    }
}

@end
