//
//  SYCommonItem.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/17.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYCommonItem.h"

@implementation SYCommonItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon{
    SYCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;

}
+ (instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title icon:nil];
}
@end
