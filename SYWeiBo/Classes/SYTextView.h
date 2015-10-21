//
//  SYTextView.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/21.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYTextView : UITextView

/**
 *  占位文字
 */
@property (nonatomic,copy) NSString *placeHolder;

/**
 *  占位文字颜色,非必输项，默认灰色
 */
@property (nonatomic,strong) UIColor *placeHolderColor;

@end
