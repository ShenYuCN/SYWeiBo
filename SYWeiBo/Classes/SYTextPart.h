//
//  SYTextPart.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/29.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 截取后的一段文字 */
@interface SYTextPart : NSObject
/** 文字内容 */
@property (nonatomic,copy) NSString *text;
/** 文字范围 */
@property (nonatomic,assign) NSRange range;
/** 是否是特殊文字 */
@property (nonatomic,assign,getter=isSpecial) BOOL special;
/** 是否是表情 */
@property (nonatomic,assign,getter=isEmotion) BOOL emotion;
@end
