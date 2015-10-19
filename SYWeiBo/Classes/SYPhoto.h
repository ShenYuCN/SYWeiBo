//
//  SYPhoto.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/19.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYPhoto : NSObject
/** 缩略图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString *thumbnail_pic;
@end
