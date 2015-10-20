//
//  SYStatusToolBar.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/19.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SYStatus;
@interface SYStatusToolBar : UIView
+(instancetype)toolbar;
@property (nonatomic,strong) SYStatus *status;
@end
