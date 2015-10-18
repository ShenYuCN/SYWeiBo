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
 *
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
-(CGSize) sizeWithFont:(UIFont *)font maxSize:(CGSize )maxSize{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
