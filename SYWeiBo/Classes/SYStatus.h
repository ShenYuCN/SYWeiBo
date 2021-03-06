//
//  SYStatus.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/15.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SYUser;
/**
 *  一个微博数据模型
 */
@interface SYStatus : NSObject
/**字符串型的微博ID */
@property (nonatomic,copy) NSString *idstr;
/**微博信息内容 */
@property (nonatomic,copy) NSString *text;

/** 微博信息内容---带属性的内容，包括高亮显示，表情 */
@property (nonatomic,copy) NSAttributedString  *attributedText;

/**微博作者的用户信息字段 详细*/
@property (nonatomic,strong) SYUser *user;
/** 微博创建时间 */
@property (nonatomic,copy) NSString *created_at;
/** 微博来源 */
@property (nonatomic,copy) NSString *source;

/** 配图数组，多图时返回多图链接。无配图返回“[]”,之后转换成SYPhoto模型数组 */
@property (nonatomic,copy) NSArray *pic_urls;

/** 转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic,strong) SYStatus *retweeted_status;

/** 被转发微博信息内容---带属性的内容，包括高亮显示，表情 */
@property (nonatomic,copy) NSAttributedString  *retweeteAttributedText;

/**	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	评论数*/
@property (nonatomic, assign) int comments_count;
/** 表态数*/
@property (nonatomic, assign) int attitudes_count;

@end
