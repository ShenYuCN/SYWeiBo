//
//  SYStatusPhotoView.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/20.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYPhoto;
/**
 *  配图列表中的一张配图
 */
@interface SYStatusPhotoView : UIImageView
@property (nonatomic,strong) SYPhoto *photo;
@end
