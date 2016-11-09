//
//  SYSearchBar.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/12.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYSearchBar.h"
#import "UIView+Extension.h"
@implementation SYSearchBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //创建搜索框对象
        self.font = [UIFont systemFontOfSize:15];
        [self setBackground:[UIImage imageNamed:@"searchbar_textfield_background"]];
        self.placeholder = @"搜索";

        //设置放大镜图标
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchIcon.size = CGSizeMake(30, 30);
        searchIcon.contentMode = UIViewContentModeCenter;
        
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar{
    return [[self alloc] init];
}


//        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
//        [self setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
//        [searchBar setValue:[UIViewContentMode UIViewContentModeCenter] forKeyPath:@"_placeholderLabel.contentMode"];

@end

