//
//  SYHomeStatusesResult.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 首页微博,加载数据的返回结果模型
    加载数据的返回结果是个字典，字典里面包含since_id  max_id totalNumber statuses等key，
    其中statuses的值是一个array（20条微博的数组）*/
@interface SYHomeStatusesResult : NSObject


/** 微博数组（装着SYStatus模型） */
@property (nonatomic,strong) NSArray *statuses;
@end
