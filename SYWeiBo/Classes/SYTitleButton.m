//
//  SYTitleButton.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/15.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYTitleButton.h"
#import "UIView+Extension.h"
@implementation SYTitleButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        //TODO: 测试代码，要删除
//        self.backgroundColor = [UIColor redColor];
//        self.imageView.backgroundColor = [UIColor blueColor];
//        self.titleLabel.backgroundColor = [UIColor greenColor];
    }
    return self;
}
// 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
-(void)setFrame:(CGRect)frame{
//    frame.size.width += 10;
    [super setFrame:frame];
}
-(void)layoutSubviews{

    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
//    self.titleLabel.x = self.imageView.x;
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 10;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    //只是修改了文字就让button自己调整大小
    [self sizeToFit];
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    //只是图片就让button自己调整大小
    [self sizeToFit];
}
@end
