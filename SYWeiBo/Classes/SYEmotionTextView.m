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
#import "SYEmotionAttachment.h"
@implementation SYEmotionTextView
-(void)insertEmotion:(SYEmotion *)emotion{
    if (emotion.code) {
        // insertText : 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
    }else if (emotion.png){
 
         // 根据附件创建一个属性文字
        SYEmotionAttachment *attach = [[SYEmotionAttachment alloc] init];
        attach.emotion = emotion;
        
        //设置模型尺寸
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        // 根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        
        //此处两种方式，方式一，直接在这里添加属性文字，在方法里面设置字体
        [self insertAttributeText:imageStr];
        
        //方法二：在这里添加，传入字体的代码块
        /**
         
         [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
         // 设置字体
         [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
         }];
         
         */
       
        
    }
}
-(NSString *)fullText{

    NSMutableString *fullText = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        SYEmotionAttachment *attach = attrs[@"NSAttachment"];
        if (attach) {//图片
            [fullText appendString:attach.emotion.chs];
        }else{//普通文本、Emoji
            NSAttributedString *attrStr = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:attrStr.string];
        }
        
    }];
    return fullText;
}

@end
