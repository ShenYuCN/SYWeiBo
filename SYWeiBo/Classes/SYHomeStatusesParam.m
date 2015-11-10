//
//  SYHomeStatusesParam.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYHomeStatusesParam.h"

#import "SYAccountTool.h"
@implementation SYHomeStatusesParam

- (NSString *)access_token{
    return [[SYAccountTool account] access_token];
}
- (NSString *)count
{
    return _count ? _count : @"20";
}
@end
