//
//  SYBadgeView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/17.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYBadgeView.h"
#import "UIView+Extension.h"
#import "NSString+SY.h"
#import "UIImage+SY.h"
@implementation SYBadgeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage resizableImage:@"main_badge" ] forState:UIControlStateNormal];
        //高度
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}
- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = [badgeValue copy];
    
    //设置文字
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    //根据文字长度计算尺寸
    CGFloat textW = [badgeValue sizeWithFont:self.titleLabel.font].width;
    CGFloat imgW = self.currentBackgroundImage.size.width;
    
    if (textW > imgW ) {
        self.width = textW + 10;
    }else{
        self.width = imgW;
    }
}
@end
