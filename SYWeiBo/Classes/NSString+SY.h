//
//  NSString+SY.h
//  sy-Lottery
//
//  Created by Shen Yu on 15/9/23.
//  Copyright (c) 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (SY)
/** 计算文字尺寸 maxSize 文字的最大尺寸*/
-(CGSize) sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/** 计算文字尺寸*/
-(CGSize) sizeWithFont:(UIFont *)font;
@end
