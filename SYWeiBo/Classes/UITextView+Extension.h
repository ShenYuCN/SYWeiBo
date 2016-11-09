//
//  UITextView+Extension.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/25.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
/** 拼接图片字符 */
-(void)insertAttributeText:(NSAttributedString *)text;
/** 拼接图片字符，附带代码块 */
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;
@end
