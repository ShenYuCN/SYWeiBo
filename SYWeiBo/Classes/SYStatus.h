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
/**微博作者的用户信息字段 详细*/
@property (nonatomic,strong) SYUser *user;
@end
