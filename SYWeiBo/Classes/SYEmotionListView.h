//
//  SYEmotionListView.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/22.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 键盘上半部分，包括UIScrollView和UIPageControl */
@interface SYEmotionListView : UIView
/** 表情模型数组 */
@property (nonatomic,strong) NSArray *emotions;
@end
