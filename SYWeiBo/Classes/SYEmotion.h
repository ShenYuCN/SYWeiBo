//
//  SYEmotion.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/23.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
/**表情模型*/
@interface SYEmotion : NSObject
/**表情的 png图片名字*/
@property (nonatomic,copy) NSString *png;
/**表情的 文字描述*/
@property (nonatomic,copy) NSString *chs;
/**emoji表情的16位二进制编码 */
@property (nonatomic,copy) NSString *code;
@end
