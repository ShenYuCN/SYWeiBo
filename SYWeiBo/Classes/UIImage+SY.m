//
//  UIImage+capture.m
//  sy-截图
//
//  Created by Shen Yu on 15/9/21.
//  Copyright (c) 2015年 Shen Yu. All rights reserved.
//

#import "UIImage+SY.h"

@implementation UIImage (SY)
/**
 *  截图
 *
 *  @param view 要截图的view
 *
 */
+(instancetype)captureWithView:(UIView *)view{
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    //将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}
/**
 *  水印
 *
 *  @param bgName   背景图片名字
 *  @param logoName 水印图片名字
 *
 *  @return UIImage
 */
+(instancetype)waterImageWithBg:(NSString *)bgName addLogo:(NSString *)logoName{
    UIImage *bgImage =[UIImage imageNamed:bgName];
    
    //获取上下文,基于位图，相当与创建了新的图片,  opaque  NO 透明
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    //画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    //画水印
    UIImage *logoImage = [UIImage imageNamed:logoName];
    CGFloat margin = 5;
    CGFloat scale = 0.2;
    CGFloat logoW = logoImage.size.width * scale ;
    CGFloat logoH = logoImage.size.height * scale;
    CGFloat logoX = bgImage.size.width - margin - logoW;
    CGFloat logoY = bgImage.size.height - margin - logoH;
    
    [logoImage drawInRect:CGRectMake(logoX, logoY, logoW, logoH)];
    
    
    //从上下文中取得制作完毕的UIImage图像
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  转换成圆形头像，带环绕的圈圈
 *
 *  @param name        要转换的图片名字
 *  @param borderWidth 环绕宽度
 *  @param borderColor 环绕颜色
 *
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**
 *  转换成圆形头像
 *
 *  @param name 要转换的图片名字
 *
 */
+ (instancetype)circleImageWithName:(NSString *)name{
    UIImage *oldImage = [UIImage imageNamed:name];
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0);
    
    //取得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画圆
    CGRect circleRect = CGRectMake(0, 0, oldImage.size.width, oldImage.size.height);
    CGContextAddEllipseInRect(ctx, circleRect);
    
    //裁剪
    CGContextClip(ctx);
    
    //画图
    [oldImage drawInRect:circleRect];
    
    //取图
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

/**
 *  通过颜色创建图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color{
    
    CGFloat imageW = 100;
    CGFloat imageH = 100;
    //开启位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    
    //画矩形框，color颜色，实心
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    //拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}
@end
