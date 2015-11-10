//
//  SYStatusTool.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYStatusTool.h"
#import "FMDB.h"
#import "SYStatus.h"
#import "MJExtension.h"
#import "SYHttpTool.h"
#import "SYHomeStatusesResult.h"
@implementation SYStatusTool

static FMDatabase *_db;
+ (void)initialize{
    //数据库路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"status.sqlite"];
    
    //得到数据库
    _db = [FMDatabase databaseWithPath:path];
    
    //打开数据库
    if ([_db open]) {
        //创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_status (id integer PRIMARY KEY AUTOINCREMENT, access_token text NOT NULL, status_idstr text NOT NULL, status_dict blob NOT NULL);"];
        if (result) {
            NSLog(@"成功创表");
        } else {
            NSLog(@"创表失败");
        }
    }
}



/**
 *
 params[@"access_token"] = account.access_token;
 params[@"since_id"] = firstStatusFrame.status.idstr;
 */
+ (void)homeStatusesWithParam:(SYHomeStatusesParam *)homeStatusesParam success:(void(^)(SYHomeStatusesResult *result))success failure:(void(^)(NSError *error))failure{
    
    // 从数据库中读取（加载）缓存数据(微博模型数组)
    NSArray *cachedHomeStatuses = [self cachedHomeStatusesWithParam:homeStatusesParam];
    if (cachedHomeStatuses.count != 0) {//有缓存数据
        if (success) {
            SYHomeStatusesResult *result = [[SYHomeStatusesResult alloc] init];
            result.statuses = cachedHomeStatuses;
            success(result);
        }
    }else {//没有缓存数据
        NSDictionary *params = [homeStatusesParam keyValues];
        [SYHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(id json) {
            
            //新浪返回的微博字典数组
            NSArray *statusDictArray = json[@"statuses"];
            //缓存
            [self saveHomeStatusDictArray:statusDictArray accessToken:homeStatusesParam.access_token];
            
            if (success) {
                //json字典转成模型
                SYHomeStatusesResult *result = [SYHomeStatusesResult objectWithKeyValues:json];
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    
    }
    
}

/**
 *  缓存 微博字典数组到数据库中
 */
+ (void)saveHomeStatusDictArray:(NSArray *)statusDictArray accessToken:(NSString *)accessToken
{
    for (NSDictionary *statusDict in statusDictArray) {
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        [_db executeUpdate:@"INSERT INTO t_home_status (access_token, status_idstr, status_dict) VALUES (?, ?, ?);",
         accessToken, statusDict[@"idstr"], data];
    }
}


/**
 *  通过请求参数去数据库中加载对应的微博数据
 *
 *  @param homeStatusesParam  请求参数
 *
 *  @return 微博模型数组
 */
+ (NSArray *)cachedHomeStatusesWithParam:(SYHomeStatusesParam *)homeStatusesParam
{
    // 创建数组缓存微博数据
    NSMutableArray *statuses = [NSMutableArray array];
    
    // 根据请求参数查询数据
    FMResultSet *resultSet = nil;
    if (homeStatusesParam.since_id) {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr > ? ORDER BY status_idstr DESC limit ?;", homeStatusesParam.access_token, homeStatusesParam.since_id, homeStatusesParam.count];
    } else if (homeStatusesParam.max_id) {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr <= ? ORDER BY status_idstr DESC limit ?;", homeStatusesParam.access_token, homeStatusesParam.max_id, homeStatusesParam.count];
    } else {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? ORDER BY status_idstr DESC limit ?;", homeStatusesParam.access_token, homeStatusesParam.count];
    }
    
    // 遍历查询结果
    while (resultSet.next) {
        NSData *statusDictData = [resultSet objectForColumnName:@"status_dict"];
        NSDictionary *statusDict = [NSKeyedUnarchiver unarchiveObjectWithData:statusDictData];
        // 字典转模型
        SYStatus *status = [SYStatus objectWithKeyValues:statusDict];
        // 添加模型到数组中
        [statuses addObject:status];
    }
    return statuses;
}
@end
