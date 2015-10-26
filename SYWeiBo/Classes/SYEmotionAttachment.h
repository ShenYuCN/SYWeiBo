//
//  SYEmotionAttachment.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/26.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYEmotion;
@interface SYEmotionAttachment : NSTextAttachment
@property (nonatomic,strong) SYEmotion *emotion;
@end
