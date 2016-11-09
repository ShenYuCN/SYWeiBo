//
//  SYSpecial.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/30.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 专门存放特殊字符串的  内容， 范围 ，矩形框 */
@interface SYSpecial : NSObject
/** 这段特殊文字的内容 */
@property (nonatomic,copy) NSString *text;
/** 这段特殊文字的范围 */
@property (nonatomic,assign) NSRange range;
/** 这段特殊文字的矩形框 （里面存放的CGRect） */
@property (nonatomic,strong) NSArray  *rects;

@end
