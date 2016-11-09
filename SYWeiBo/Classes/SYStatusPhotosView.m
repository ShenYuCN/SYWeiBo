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
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

//每张配图的宽高
#define kSYStatusPhotosWH  (([UIScreen mainScreen].bounds.size.width - 40) / 3)
//每张配图的间距
#define kSYStatusPhotosMargin 10
//最大列数
#define kSYPhotoViewMaxCol(count) ((count == 4)?2:3)
//最大图片数量
#define SYStatusPhotosMaxCount 9
@interface SYStatusPhotosView()
@property (nonatomic,assign) CGFloat photosWH;
@end

@implementation SYStatusPhotosView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 预先创建9个图片控件
        for (int i = 0; i < SYStatusPhotosMaxCount; i++) {
            SYStatusPhotoView *photoView = [[SYStatusPhotoView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    
//    UIView *cover =[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    cover.backgroundColor = [UIColor blackColor];
//    [[UIApplication sharedApplication].keyWindow addSubview:cover];
//    
//    SYStatusPhotoView *photoView = (SYStatusPhotoView *)recognizer.view;
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = photoView.image;
//    imageView.frame = [self convertRect:photoView.frame toView:cover];
//    [cover addSubview:imageView];
    
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    NSUInteger count = self.photos.count;
    for (int i = 0; i<count; i++) {
        SYPhoto *pic = self.photos[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        // 设置来源于哪一个UIImageView
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 3.显示浏览器
    [browser show];
}


-(void)setPhotos:(NSArray *)photos{

    _photos = photos;
    
    //遍历UIImageView,设置图片的显示和隐藏
    for (int i = 0; i < SYStatusPhotosMaxCount; i ++) {
        SYStatusPhotoView *photoView = self.subviews[i];
        if (i < photos.count) {
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
