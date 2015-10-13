//
//  SYTabBar.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/12.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYTabBar;

@protocol SYTabBarDelegate <UITabBarDelegate>
@optional
-(void)tabBarDidClickPlusBtn:(SYTabBar *)tabBar;

@end
@interface SYTabBar : UITabBar
@property (nonatomic,weak) id<SYTabBarDelegate> delegeta;
@end
