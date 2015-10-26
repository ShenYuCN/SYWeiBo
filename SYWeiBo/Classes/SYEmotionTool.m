//
//  SYEmotionTool.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/26.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionTool.h"
//存储最近表情模型数组沙盒路径
#define SYRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]


static NSMutableArray *_recentEmotions;

@implementation SYEmotionTool

/**
 *  这个类第一次加载的时候调用，只会调用一次
 */
+ (void)initialize
{
    //写这个方法的目的，减少IO操作，只有第一次读取文件，之后通过static属性保存在内存中
    //（写入文件次数正常不变）
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:SYRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

/**
 *  返回装着SYEmotion模型的数组
 */
+(NSArray *)recentEmotions{

    return _recentEmotions;
}


/** 添加SYEmotion模型到沙盒 */
+(void)addRecentEmotion:(SYEmotion *)emotion{
    
    //删除重复表情,内部调用的是isEuare方法
    [_recentEmotions removeObject:emotion];
    
    //添加表情模型到数组最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    //将表情写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:SYRecentEmotionsPath];
    
}
@end
