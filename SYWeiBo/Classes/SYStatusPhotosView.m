//
//  SYStatusPhotosView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/20.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYStatusPhotosView.h"
#import "SYPhoto.h"
#import "UIImageView+WebCache.h"
#import "SYStatusPhotoView.h"


//每张配图的宽高
#define kSYStatusPhotosWH 80
//每张配图的间距
#define kSYStatusPhotosMargin 10
//最大列数
#define kSYPhotoViewMaxCol(count) ((count == 4)?2:3)

@implementation SYStatusPhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos{

    _photos = photos;
    int photosCount = (int)photos.count;
    //创建足够数量的UIImageView
    while (self.subviews.count < photosCount) {
        SYStatusPhotoView *photoView = [[SYStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    //遍历UIImageView,设置图片
    for (int i = 0; i < self.subviews.count; i ++) {
        SYStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) {
            photoView.hidden = NO;
            photoView.photo = photos[i];
        }else{
            photoView.hidden = YES;
        }
    }
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    int maxCol = kSYPhotoViewMaxCol(self.photos.count);
 
    for (int i = 0; i < self.photos.count; i ++) {
        SYStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCol;
        int row = i / maxCol;
        CGFloat photoX = col * (kSYStatusPhotosWH + kSYStatusPhotosMargin);
        CGFloat photoY = row * (kSYStatusPhotosWH + kSYStatusPhotosMargin);
        CGFloat photoW = kSYStatusPhotosWH;
        CGFloat photoH = kSYStatusPhotosWH;
        photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
    }
}

/**
 *  配图的整体大小
 *
 *  @param count 配图的数量
 */
+ (CGSize)sizeWithCount:(int)count{
    
    //最大的列数
    int maxCols = 3;
    
    //列数
    int cols = (count >= maxCols) ? maxCols : count;
    CGFloat photoW = cols * kSYStatusPhotosWH + (cols -1) * kSYStatusPhotosMargin;
    
    
    //行数
    int rows = (count + maxCols - 1) / maxCols;
    CGFloat photoH = rows * kSYStatusPhotosWH + (rows -1) * kSYStatusPhotosMargin;
    
    return CGSizeMake(photoW, photoH);
    
    
}
@end
