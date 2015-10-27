//
//  SYHttpTool.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/27.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface SYHttpTool : NSObject
/**
 *  post方法发送请求
 *
 *  @param URLString  url地址
 *  @param parameters 要传递的参数
 *  @param success    请求成功执行的代码块
 *  @param failure    请求失败执行的代码块
 */
+ (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
/**
 *  get方法发送请求
 *
 *  @param URLString  url地址
 *  @param parameters 要传递的参数
 *  @param success    请求成功执行的代码块
 *  @param failure    请求失败执行的代码块
 */
+ (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

/**
 *  post方法发送请求,带图片的，转换成二进制数据上传
 *
 *  @param URLString  url地址
 *  @param parameters 要传递的参数
 *  @param block      <#block description#>
 *  @param success    请求成功执行的代码块
 *  @param failure    请求失败执行的代码块
 */
+ (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void(^)(id <AFMultipartFormData> formData))block  success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
@end
