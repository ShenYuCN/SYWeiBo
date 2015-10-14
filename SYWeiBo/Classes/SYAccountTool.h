//
//  SYAccountTool.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/14.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYAccount.h"
@interface SYAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+(void)saveAccount:(SYAccount *)account;

/**
 *  取出账号信息
 *
 *  @return 账号模型，若过期，返回nil
 */
+(SYAccount *)account;
@end
