//
//  SYUser.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/15.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    SYUserVerifiedTypeNone = -1, // 没有任何认证
    SYUserVerifiedTypeNonePerson = 1, //无认证
    SYUserVerifiedPersonal = 0,  // 个人认证
    
    SYUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    SYUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    SYUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    SYUserVerifiedDaren = 220 // 微博达人

}SYUserVerifiedType;

@interface SYUser : NSObject

/**用户UID */
@property (nonatomic,copy) NSString *idstr;
/**(昵称)友好显示名称*/
@property (nonatomic,copy) NSString *name;
/**用户头像地址（中图），50×50像素*/
@property (nonatomic,copy) NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;

@property (nonatomic,assign) SYUserVerifiedType verified_type;
@end
