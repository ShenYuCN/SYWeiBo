//
//  SYStatusTool.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYHomeStatusesParam.h"
#import "SYHomeStatusesResult.h"
/**
 *  微博业务类，发微博，删微博，加载首页微博数据
 */
@interface SYStatusTool : NSObject


+ (void)homeStatusesWithParam:(SYHomeStatusesParam *)homeStatusesParam  success:(void(^)(SYHomeStatusesResult *result))success failure:(void(^)(NSError *error))failure;
/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
//+ (void)homeStatusesWithParam:(HMHomeStatusesParam *)param success:(void (^)(HMHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
//+ (void)sendStatusWithParam:(HMSendStatusParam *)param success:(void (^)(HMSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
