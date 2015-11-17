//
//  UIImage+capture.h
//  sy-截图
//
//  Created by Shen Yu on 15/9/21.
//  Copyright (c) 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SY)
/**截图*/
+(instancetype)captureWithView:(UIView *)view;
/**水印*/
+(instancetype)waterImageWithBg:(NSString *)bgName addLogo:(NSString *) logoName;
/**转换成圆形头像，带白边*/
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**转换成圆形头像*/
+ (instancetype)circleImageWithName:(NSString *)name;
/**返回一张可以随意拉伸不变形的图片*/
+ (UIImage *)resizableImage:(NSString *)name;

/** 通过颜色创建图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
