//
//  SYStatusPhotosView.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/20.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYStatusPhotosView : UIImageView

@property (nonatomic,strong) NSArray *photos;
/**
 *  配图的整体大小
 */
+ (CGSize)sizeWithCount:(int)count;
@end
