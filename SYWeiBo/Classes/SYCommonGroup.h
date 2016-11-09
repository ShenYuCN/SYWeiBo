//
//  SYCommonGroup.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/17.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 组模型：包含组头信息、组尾信息、所有行模型 */
@interface SYCommonGroup : NSObject
/** 组头 */
@property (nonatomic,copy) NSString *header;

/** 组尾 */
@property (nonatomic,copy) NSString *footer;

/** 这组的所有行模型（每一行都是SYCommonItem以及子类模型） */
@property (nonatomic,strong) NSArray *items;


+ (instancetype)group;
@end
