//
//  SYPhoto.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/19.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYPhoto.h"

@implementation SYPhoto
- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
@end
