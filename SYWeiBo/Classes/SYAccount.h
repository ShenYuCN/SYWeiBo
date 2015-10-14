//
//  SYAccount.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/14.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYAccount : NSObject<NSCoding>

/** 	用于调用access_token，接口获取授权后的access token*/
@property (nonatomic,copy) NSString *access_token;

/**		access_token的生命周期，单位是秒数*/
@property (nonatomic,copy) NSString *expires_in;


/**		当前授权用户的UID*/
@property (nonatomic,copy) NSString *uid;
/**
 *  生成access_token 的时间
 */
@property (nonatomic,copy) NSDate *create_time;

/**
 *  昵称
 */
@property (nonatomic,copy) NSString *name;
+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
