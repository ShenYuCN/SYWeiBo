//
//  SYCommonItem.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/17.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
/** SYCommonItem模型：描述每一行的信息：标题，子标题，图标，右侧样式（箭头，文字，数字，开关，打钩） */
@interface SYCommonItem : NSObject
/** 图标 */
@property (nonatomic,copy) NSString *icon;
/** 标题 */
@property (nonatomic,copy) NSString *title;
/** 子标题 */
@property (nonatomic,copy) NSString *subTitle;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
