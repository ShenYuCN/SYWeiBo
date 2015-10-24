//
//  SYEmotionPageView.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/24.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

// 最大列数
#define kSYEmotionMaxCols 7
// 最大行数
#define kSYEmotionMaxRows 3
// 每一页最大的表情个数
#define kSYEmotionPageSize (kSYEmotionMaxCols * kSYEmotionMaxRows - 1)
@interface SYEmotionPageView : UIView

@property (nonatomic,strong) NSArray *emotions;

@end
