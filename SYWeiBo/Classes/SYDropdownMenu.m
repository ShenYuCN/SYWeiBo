//
//  SYDropdownMenu.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/12.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYDropdownMenu.h"
#import "UIView+Extension.h"

@interface SYDropdownMenu()
/**
 *  显示内容的容器
 */
@property (nonatomic,weak) UIImageView *containerView;
@end


@implementation SYDropdownMenu

-(UIImageView *)containerView{
    if (_containerView == nil) {
        
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        [self addSubview:containerView];
        containerView.userInteractionEnabled = YES; // 开启交互
        
        //懒加载,但控件是弱指针weak，所有必须将上面创建的view赋值给这个弱指针
        //或者可以直接将控件设置成强指针
        self.containerView = containerView;
    }
    return _containerView;
}
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //清除颜色，透明
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+(instancetype)menu{
    return [[self alloc] init];

}
-(void)showFrom:(UIView *)from{

    //1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //2.添加自己到最上面的窗口,
    [window addSubview:self];
    
    //3.设置尺寸，自己就是整个窗口，相当于蒙版
    self.frame = window.bounds;

    //4.调整灰色图片的位置
    
    //坐标系转换，两种方式， [from.superView convertRect:from.frame toView:window];
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    self.containerView.y = CGRectGetMaxY(newFrame);
    self.containerView.centerX = CGRectGetMidX(newFrame);
    
//    self.containerView.x = (self.width - self.containerView.width) * 0.5;
    
}
-(void)setContent:(UIView *)content{

    _content = content;
    
    //调整内容在灰色容器的位置
    content.x = 10;
    content.y = 15;
    
    //调整内容的宽度
//    content.width = self.containerView.width - content.x * 2;
    NSLog(@"%@",NSStringFromCGRect(content.frame));
    
    //设置灰色容器的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    //添加内容到灰色容器中
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController{

    _contentController = contentController;
    
    self.content = contentController.view;
    
}
/**
 *  销毁
 */
-(void)dismiss{
    
    [self removeFromSuperview];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
@end
