//
//  SYDropdownMenu.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/12.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYDropdownMenu : UIView
/**
 *  内容view
 */
@property (nonatomic,strong) UIView *content;
/**
 *  内容View的控制器
 */
@property (nonatomic,strong) UIViewController *contentController;

+(instancetype)menu;
/**
 *  显示
 */
-(void)showFrom:(UIView *)from;
/**
 *  销毁
 */
-(void)dismiss;
@end
