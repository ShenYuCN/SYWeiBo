//
//  SYEmotion.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/23.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//



#import "SYEmotion.h"
#import "MJExtension.h"

@interface SYEmotion() <NSCoding>

@end

@implementation SYEmotion

//一句话替换下面的解档和归档方法
MJCodingImplementation



/**
 *  任何对象都有这个方法，用来比较两个对象是否一样
 */
-(BOOL)isEqual:(SYEmotion *)other{

    return [self.png isEqualToString:other.png] || [self.code isEqualToString: other.code];
}

/**
 *  从文件解析时调用,解档，解码
 */
//-(instancetype)initWithCoder:(NSCoder *)decoder{
//    if (self = [super initWithCoder:decoder]) {
//        self.png = [decoder decodeObjectForKey:@"png"];
//        self.chs = [decoder decodeObjectForKey:@"chs"];
//        self.code = [decoder decodeObjectForKey:@"code"];
////        [self enumerateIvarsWithBlock:^(MJIvar *ivar, BOOL *stop) {
////            ivar.value = [decoder decodeObjectForKey:ivar.name];
////        }];
//    }
//    return self;
//}

/**
 *  归档，编码
 */
//-(void)encodeWithCoder:(NSCoder *)encoder{
//    [encoder encodeObject:self.png forKey:@"png"];
//    [encoder encodeObject:self.code forKey:@"code"];
//    [encoder encodeObject:self.chs forKey:@"chs"];
//}



@end
