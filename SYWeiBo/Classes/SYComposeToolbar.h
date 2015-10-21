//
//  SYComposeToolbar.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/21.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    SYComposeToolbarButtonTypeCamera, // 拍照
    SYComposeToolbarButtonTypePicture, // 相册
    SYComposeToolbarButtonTypeMention, // @
    SYComposeToolbarButtonTypeTrend, // #
    SYComposeToolbarButtonTypeEmotion // 表情
    
}SYComposeToolbarButtonType;
@class SYComposeToolbar;

@protocol SYComposeToolBarDelegate <NSObject>
@optional
-(void)compostToolBar:(SYComposeToolbar *)toolbar didClickButton:(SYComposeToolbarButtonType)buttonType;

@end

@interface SYComposeToolbar : UIView
@property (nonatomic,weak) id<SYComposeToolBarDelegate> delegate;
@end
