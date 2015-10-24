//
//  SYEmotionPopView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/24.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionPopView.h"
#import "SYEmotionButton.h"
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
@end
