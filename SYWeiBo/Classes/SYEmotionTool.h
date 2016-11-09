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


/**
 *  通过表情图片描述找到 表情模型
 *
 *  @param chs chs
 *
 *  @return SYEmotion
 */
+ (SYEmotion *)emotionWithChs:(NSString *)chs;



/** 返回 默认 表情模型 数组 */
+ (NSArray *)defaultEmotions;
/** 返回 emoji 表情模型 数组*/
+ (NSArray *)emojiEmotions;
/** 返回 lxh 表情模型 数组*/
+ (NSArray *)lxhEmotions;
@end
