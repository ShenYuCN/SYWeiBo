//
//  SYLoadMoreFooter.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/16.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYLoadMoreFooter.h"

@implementation SYLoadMoreFooter
+(instancetype)footerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"SYLoadMoreFooter" owner:nil options:nil] lastObject];
}
@end
