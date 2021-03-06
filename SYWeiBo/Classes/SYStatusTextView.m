//
//  SYStatusTextView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/29.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYStatusTextView.h"
#import "SYSpecial.h"
#define SYStatusTextViewCoverTag 999
#define SYSpecialText @"SYSpecialText"
#define SYSpecialDidSelectedNotification  @"SYSpecialDidSelectedNotification"

@implementation SYStatusTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame] ) {
        self.backgroundColor = [UIColor clearColor];
        //不可编辑
        self.editable = NO;
        //内边距
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        //停止滚动，让文本显示出来
        self.scrollEnabled = NO;
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //触摸对象
    UITouch *touch = [touches anyObject];
    //触摸点
    CGPoint point = [touch locationInView:self];
    
    // 初始化矩形框
    [self setupSpecialRects];
    
    // 根据触摸点获得被触摸的 特殊字符串模型
    SYSpecial *special = [self touchingSpecialWithPoint:point];
    
    // 在被触摸的特殊字符串 后面 加一段高亮背景
    [self showLinkBackground:special.rects];
   
    
}

/**
 *  初始化矩形框
 */
-(void)setupSpecialRects{
    
    //找出这条微博的所有特殊字符串specials模型数组
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    
    for (SYSpecial *special in specials) {
        
        //通过设置 self.selectedRange  间接设置 self.select edTextRange
        self.selectedRange = special.range;
        
        //获得选中范围的 矩形框数组
        NSArray *selectedRects = [self selectionRectsForRange:self.selectedTextRange];
        
//        NSLog(@"%@",selectedRects);
        
        //清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        //获取special 的rects属性，将特殊字符串的rect存放到这个数组中
        NSMutableArray *rects = [[NSMutableArray alloc] init];
        for (UITextSelectionRect *selectedRect  in selectedRects) {
            CGRect rect = selectedRect.rect;
            if (rect.size.width == 0|| rect.size.height == 0) continue;
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
        special.rects = rects;
    }

}
/**
 *  根据触摸点获得被触摸的 特殊字符串模型
 *
 *  @param point point
 *
 *  @return SYSpecial
 */
- (SYSpecial *)touchingSpecialWithPoint:(CGPoint)point{
    
    //找出这条微博的所有特殊字符串specials模型数组
    NSArray *specilas = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (SYSpecial *special in specilas){
        //TODO: 直接写rect，不写value
        for (NSValue *valueRect in special.rects) {
            if ( CGRectContainsPoint(valueRect.CGRectValue, point)) {//某个特殊字符串)
                return special;
            }
        }
    }
    
    return nil;
}
/**
 *  显示链接的背景
 */
- (void)showLinkBackground:(NSArray *)rects{
    for (NSValue *rectValue in rects) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3];
        view.frame = rectValue.CGRectValue;
        view.tag = SYStatusTextViewCoverTag;
        view.layer.cornerRadius = 5;
        [self insertSubview:view atIndex:0];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touche = [touches anyObject];
    CGPoint point = [touche locationInView:touche.view];
        
    SYSpecial *special = [self touchingSpecialWithPoint:point];
    if (special) {
        [[NSNotificationCenter defaultCenter] postNotificationName: SYSpecialDidSelectedNotification object:nil userInfo:@{SYSpecialText : special.text}];
    }
    
    
    [self touchesCancelled:touches withEvent:event];

}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (UIView *view in self.subviews) {
            if (view.tag == SYStatusTextViewCoverTag) {
                [view removeFromSuperview];
            }
        }
        
    });
}

/**
 告诉系统:触摸点point是否在这个UI控件身上
 */

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // 初始化矩形框
    [self setupSpecialRects];
    
    // 根据触摸点获得被触摸的特殊字符串
    SYSpecial *special = [self touchingSpecialWithPoint:point];
    
    if (special) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  这个方法会返回能够处理事件的控件
 *  这个方法可以用来拦截所有触摸事件
 *  @param point 触摸点
 */
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if ([self touchingSpecialWithPoint:point]) {
//        return self;
//    }
//    return nil;
//}


// 触摸事件的处理
// 1.判断触摸点在谁身上: 调用所有UI控件的- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
// 2.pointInside返回YES的控件就是触摸点所在的UI控件
// 3.由触摸点所在的UI控件选出处理事件的UI控件: 调用- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
@end
