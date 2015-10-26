//
//  SYEmotionTool.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/26.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SYEmotion;
@interface SYEmotionTool : NSObject
/** 读取沙盒中存的最近的表情模型数组 */
+(NSArray *)recentEmotions;
/** 添加SYEmotion模型到沙盒 */
+(void)addRecentEmotion:(SYEmotion *)emotion;
@end
