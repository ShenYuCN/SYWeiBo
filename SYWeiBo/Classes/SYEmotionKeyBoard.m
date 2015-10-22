//
//  SYEmotionKeyBoard.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/22.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYEmotionKeyBoard.h"
#import "SYEmotionTabBar.h"
#import "SYEmotionListView.h"
#import "UIView+Extension.h"

@interface SYEmotionKeyBoard()
/** tabBar */
@property(nonatomic,weak) SYEmotionTabBar *tabBar;
/** 表情内容 */
@property (nonatomic,weak) SYEmotionListView *listView;
@end
@implementation SYEmotionKeyBoard

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"init key board");
        SYEmotionTabBar *tabBar = [[SYEmotionTabBar alloc] init];
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        SYEmotionListView *listView = [[SYEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //tabBar 的Frame
    self.tabBar.x = 0;
    self.tabBar.height = 37;
    self.tabBar.width = self.width;
    self.tabBar.y = self.height - self.tabBar.height;
    
    //listView 的frame
    self.listView.x = 0;
    self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabBar.y;
}

@end
