//
//  SYStatusFrame.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 昵称字体
#define kSYStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define kSYStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define kSYStatusCellSourceFont kSYStatusCellTimeFont
// 正文字体
#define kSYStatusCellContentFont [UIFont systemFontOfSize:14]

// 转发微博正文字体
#define kSYStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

//cell的左右边距
#define kSYStatusCellBorder 10

@class SYStatus;
/**
 *  一个SYStatusFrame模型:
 * 包含一个cell内部所有子控件的Frame数据
 * 包含一个数据模型SYStatus，用这个来计算Frame
 * 包含一个Cell的高度
 */
@interface SYStatusFrame : NSObject

/** 一条微博数据模型 */
@property (nonatomic,strong) SYStatus *status;

/**原创微博整体*/
@property (nonatomic,assign) CGRect originalViewF;
/**头像*/
@property (nonatomic,assign) CGRect iconViewF;
/**配图*/
@property (nonatomic,assign) CGRect photosViewF;
/**会员图标*/
@property (nonatomic,assign) CGRect vipViewF;
/** 昵称 */
@property (nonatomic,assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic,assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic,assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic,assign) CGRect contentLabelF;


/** 转发微博整体 */
@property (nonatomic,assign) CGRect retweetViewF;
/** 转发微博正文（@+昵称+正文） */
@property (nonatomic,assign) CGRect retweetContentLabelF;
/** 转发微博配图 */
@property (nonatomic,assign) CGRect retweetPhotosViewF;

/** 底部工具条 */
@property (nonatomic,assign) CGRect toolbarF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
