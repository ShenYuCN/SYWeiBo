//
//  SYAccountTool.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/14.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYAccountTool.h"
#import "SYAccount.h"

//存储账号沙盒路径
#define SYAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
@implementation SYAccountTool


/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+(void)saveAccount:(SYAccount *)account{
    // 自定义对象的存储必须用NSKeyedArchiver，内部调用encodeWithCoder
    [NSKeyedArchiver archiveRootObject:account toFile:SYAccountPath];
}

/**
 *  取出账号信息
 *
 *  @return 账号模型，若过期，返回nil
 */
+(SYAccount *)account{

    SYAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SYAccountPath];
    
    //过期秒数转成long long类型
    long long expires_in = [account.expires_in longLongValue];
    //过期时间
    NSDate *expires_time = [account.create_time dateByAddingTimeInterval:expires_in];
    //当前实际
    NSDate *now = [NSDate date];
    
    
    /**
     NSOrderedAscending = -1L, 升序
     NSOrderedSame, 一样
     NSOrderedDescending 降序
     */
    
    // 如果expiresTime > now，没有过期 ,降序
    NSComparisonResult result = [expires_time compare:now];
    
    if (result != NSOrderedDescending) {
        return  nil;
    }
    return account;
}
@end
