//
//  SYEmotionPopView.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/24.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYEmotion;
@interface SYEmotionPopView : UIView
+(instancetype)popView;
@property (nonatomic,strong) SYEmotion *emotion;
@end
