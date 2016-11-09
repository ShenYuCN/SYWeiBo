//
//  SYEmotionAttachment.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/26.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionAttachment.h"
#import "SYEmotion.h"
@implementation SYEmotionAttachment
-(void)setEmotion:(SYEmotion *)emotion{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
