//
//  SYEmotionPopView.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/24.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYEmotion,SYEmotionButton;
@interface SYEmotionPopView : UIView
+(instancetype)popView;
@property (nonatomic,strong) SYEmotion *emotion;
/** 在表情按钮btn处  显示popView */
-(void)showFrom:(SYEmotionButton *)btn;
@end
