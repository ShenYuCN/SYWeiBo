//
//  SYStatus.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/15.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYStatus.h"
#import "SYPhoto.h"
#import "MJExtension.h"

@implementation SYStatus
/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class
 */
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [SYPhoto class]};
}
@end
