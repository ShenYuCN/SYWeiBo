//
//  NSString+SY.m
//  sy-Lottery
//
//  Created by Shen Yu on 15/9/23.
//  Copyright (c) 2015年 Shen Yu. All rights reserved.
//

#import "NSString+SY.h"
#import <UIKit/UIKit.h>
@implementation NSString (SY)
/**
 *  计算文字尺寸
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
-(CGSize) sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
/**
 *  计算文字尺寸
 *  @param font    文字的字体
 */
-(CGSize) sizeWithFont:(UIFont *)font{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}



@end
