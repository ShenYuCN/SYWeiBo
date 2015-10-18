//
//  SYStatusFrame.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYStatusFrame.h"
#import "SYStatus.h"
#define kSYStatusFrameBorder 10
@implementation SYStatusFrame
-(void)setStatus:(SYStatus *)status{
    _status = status;
    /**头像*/
    CGFloat iconViewWH = 50;
    self.iconViewF =CGRectMake(kSYStatusFrameBorder, kSYStatusFrameBorder, iconViewWH, iconViewWH);
  
    self.cellHeightF = 70;
}

@end
