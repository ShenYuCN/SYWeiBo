//
//  SYEmotionPopView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/24.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionPopView.h"
#import "SYEmotionButton.h"
#import "UIView+Extension.h"
@interface SYEmotionPopView()
@property (weak, nonatomic) IBOutlet SYEmotionButton *button;
@end
@implementation SYEmotionPopView

+(instancetype)popView{
    return [[[NSBundle mainBundle] loadNibNamed:@"SYEmotionPopView" owner:nil options:nil] lastObject];
}
-(void)setEmotion:(SYEmotion *)emotion{
    _emotion = emotion;
    self.button.emotion = emotion;
}

/**
 *  在btn处显示popView
 */
-(void)showFrom:(SYEmotionButton *)btn{
    if (btn == nil)  return;
    //给popView传递模型数据
    self.emotion = btn.emotion;
    
    //将popView添加到最上面的window上面
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //设置popView的位置
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    self.centerX = CGRectGetMidX(btnFrame);
    self.y = CGRectGetMidY(btnFrame) - self.height;
    
}
@end
