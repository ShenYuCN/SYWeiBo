//
//  SYUser.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/15.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYUser.h"
@implementation SYUser
-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    self.vip = mbtype >2;
}
@end
