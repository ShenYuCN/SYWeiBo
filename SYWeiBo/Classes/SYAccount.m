//
//  SYAccount.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/14.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYAccount.h"

@implementation SYAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    SYAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    
    // 获得账号存储的时间（accessToken的产生时间）
    account.create_time = [NSDate date];
    
    return account;
}
/**
 *  当一个对象要归档到沙盒中时调用此方法
 *  说明一个对象的哪些属性需要归档
 */
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeObject:self.expires_in forKey:@"expires_in"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.create_time forKey:@"create_time"];
    [coder encodeObject:self.name forKey:@"name"];
}

/**
 *  从沙盒中解档（解析）对象
 *  说明要解析哪些对象
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in   = [decoder decodeObjectForKey:@"expires_in"];
        self.uid          = [decoder decodeObjectForKey:@"uid"];
        self.create_time  = [decoder decodeObjectForKey:@"create_time"];
        self.name         = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
