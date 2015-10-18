//
//  SYUser.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/15.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYUser : NSObject
/**用户UID */
@property (nonatomic,copy) NSString *idstr;
/**(昵称)友好显示名称*/
@property (nonatomic,copy) NSString *name;
/**用户头像地址（中图），50×50像素*/
@property (nonatomic,copy) NSString *profile_image_url;
@end
