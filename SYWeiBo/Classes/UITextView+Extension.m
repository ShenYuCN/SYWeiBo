//
//  UITextView+Extension.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/25.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
-(void)insertAttributeText:(NSAttributedString *)text{

//   如果使用代码块，则使用这句代码
//    [self insertAttributedText:text settingBlock:nil];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedString appendAttributedString:self.attributedText];
    
    //拼接图片
    NSUInteger loc = self.selectedRange.location;
    [attributedString insertAttributedString:text atIndex:loc];
    
    //插入图片后，将光标放置在图片后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
    
    //设置字体，保证每个表情和文本相同，不会越来越小
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedString.length)];
    
    //将拼接后的属性字符赋值给textView
    self.attributedText = attributedString;
    
}

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接其他文字
    NSUInteger loc = self.selectedRange.location;
    [attributedText insertAttributedString:text atIndex:loc];
    
    // 调用外面传进来的代码
    if (settingBlock) {
        settingBlock(attributedText);
    }
    
    self.attributedText = attributedText;
    
    // 移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
@end
