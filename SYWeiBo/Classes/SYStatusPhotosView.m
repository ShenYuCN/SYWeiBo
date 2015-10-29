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
#import "UIView+Extension.h"



//每张配图的宽高
#define kSYStatusPhotosWH  (([UIScreen mainScreen].bounds.size.width - 40) / 3)
//每张配图的间距
#define kSYStatusPhotosMargin 10
//最大列数
#define kSYPhotoViewMaxCol(count) ((count == 4)?2:3)
@interface SYStatusPhotosView()
@property (nonatomic,assign) CGFloat photosWH;
@end

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
    
    int maxCol = [self photosColCount:self.photos.count];
 
    for (int i = 0; i < self.photos.count; i ++) {
        SYStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCol;
        int row = i / maxCol;
        
        CGFloat photoW = self.photosWH;
        CGFloat photoH = photoW;
        CGFloat photoX = col * (photoW + kSYStatusPhotosMargin);
        CGFloat photoY = row * (photoW + kSYStatusPhotosMargin);
        photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
    }
}

-(int)photosColCount:(NSUInteger)photosCount{
    if (photosCount == 1){
        self.photosWH = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
        return 1;
    }
    self.photosWH = kSYStatusPhotosWH;
    return (photosCount == 4) ? 2 : 3;
}
/**
 *  配图的整体大小
 *
 *  @param count 配图的数量
 */
+ (CGSize)sizeWithCount:(int)count{
    
    //最大的列数
    int maxCols = 3;
    CGFloat photoWH = (([UIScreen mainScreen].bounds.size.width - 40) / 3);
    if (count == 1){
        photoWH = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
    }
    
    //列数
    int cols = (count >= maxCols) ? maxCols : count;
    CGFloat photoW = cols * photoWH + (cols -1) * kSYStatusPhotosMargin;
    
    
    //行数
    int rows = (count + maxCols - 1) / maxCols;
    CGFloat photoH = rows * photoWH + (rows -1) * kSYStatusPhotosMargin;
    
    return CGSizeMake(photoW, photoH);
    
    
}
@end
