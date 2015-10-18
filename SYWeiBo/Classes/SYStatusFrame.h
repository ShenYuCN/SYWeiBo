//
//  SYStatusFrame.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SYStatus;
/**
 *  一个SYStatusFrame模型:
 * 包含一个cell内部所有子控件的Frame数据
 * 包含一个数据模型SYStatus，用这个来计算Frame
 * 包含一个Cell的高度
 */
@interface SYStatusFrame : NSObject

@property (nonatomic,strong) SYStatus *status;
/**原创微博整体*/
@property (nonatomic,assign) CGRect originalViewF;
/**头像*/
@property (nonatomic,assign) CGRect iconViewF;
/**配图*/
@property (nonatomic,assign) CGRect photoViewF;
/**会员图标*/
@property (nonatomic,assign) CGRect vipViewF;
/** 昵称 */
@property (nonatomic,assign) CGRect nameLavelF;
/** 时间 */
@property (nonatomic,assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic,assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic,assign) CGRect contentLabelF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeightF;
@end
