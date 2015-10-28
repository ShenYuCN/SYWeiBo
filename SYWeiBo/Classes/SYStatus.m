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
#import "NSDate+Extension.h"
#import "RegexKitLite.h"
#import <UIKit/UIKit.h>
#import "SYUser.h"
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

/**
 *  重写转发的微博模型内容
 */
-(void)setRetweeted_status:(SYStatus *)retweeted_status{

    _retweeted_status = retweeted_status;
    
    NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status.user.name,retweeted_status.text];
    self.retweeteAttributedText = [self attributedTextWithText:retweetContent];
}

/**
 *  重写set方法，微博的正文，普通文字 --->属性文字
 */
-(void)setText:(NSString *)text{
    _text = [text copy];
    self.attributedText = [self attributedTextWithText:text];
}



/**
 *  普通文字 ---> 属性文字
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
-(NSMutableAttributedString *)attributedTextWithText:(NSString *)text{
    
    //利用text生成attributedString
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    
    //表情正则规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    //@的规则
    NSString *atPattern = @"\\@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    //#话题# 的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    //url的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",emotionPattern,atPattern,topicPattern,urlPattern];
    
    //遍历所有特殊字符串
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [attributedText addAttribute:NSForegroundColorAttributeName   value:[UIColor redColor] range:*capturedRanges];
    }];
    
    
    
    //拼接表情
//    NSAttributedString *str = [str string]
    NSTextAttachment *attach  = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"d_aini"];
    attach.bounds = CGRectMake(0, -3, 15, 15);
    [attributedText insertAttributedString:[NSAttributedString attributedStringWithAttachment:attach ] atIndex:0];
    return attributedText;
}

/**
 1.今年
 1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 
 2> 昨天
 * 昨天 xx:xx
 
 3> 其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 
 // E:星期几
 // M:月份
 // d:几号(这个月的第几天)
 // H:24小时制的小时
 // m:分钟
 // s:秒
 // y:年
 */
-(NSString *)created_at{
    
    
    //这是get方法，会被调用多次，每次cell滚动都会调用
    //而对于set方法，只有在字典转模型才会，基本值调用一次

    // _created_at == Thu Oct 16 17:06:25 +0800 2014
    // dateFormat  == EEE MMM dd HH:mm:ss Z yyyy
    // NSString --> NSDate
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) {//今年
        if ([createDate isYesterday]) {//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if([createDate isToday]){//今天
            if (cmps.hour > 1) {//几小时前
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            } else if(cmps.minute >1) {
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        
        }else{//今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{//不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    
    }
    
    return _created_at;
    
}
/**
 *  设置来源
 */
-(void)setSource:(NSString *)source{
    if ([source isEqualToString:@""]) return;
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    //range.length = [source rangeOfString:@"<" options:NSBackwardsSearch];
    _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];
  
}
@end
