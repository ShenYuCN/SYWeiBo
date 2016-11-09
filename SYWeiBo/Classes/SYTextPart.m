//
//  SYTextPart.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/29.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYTextPart.h"

@implementation SYTextPart
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> {text: %@, range: %@}", self.class, self, self.text, NSStringFromRange(self.range)];
}
@end
