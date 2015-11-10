//
//  SYHomeStatusesResult.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYHomeStatusesResult.h"
#import "MJExtension.h"
#import "SYStatus.h"
@implementation SYHomeStatusesResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [SYStatus class]};
}

@end
