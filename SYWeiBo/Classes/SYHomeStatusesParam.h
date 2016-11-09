//
//  SYHomeStatusesParam.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 模型----首页微博中加载数据的请求参数 */
@interface SYHomeStatusesParam : NSObject

/**采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, copy) NSString *access_token;

/**若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0*/
@property (nonatomic, strong) NSString *since_id;

/**若指定此参数，则返回ID小于或等于max_id的微博，默认为0。*/
@property (nonatomic, strong) NSNumber *max_id;

/**单页返回的记录条数，最大不超过100，默认为20。*/
@property (nonatomic, strong) NSString *count;
@end
