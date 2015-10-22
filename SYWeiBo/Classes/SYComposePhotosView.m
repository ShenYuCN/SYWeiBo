//
//  SYComposePhotoView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/21.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYComposePhotosView.h"

@implementation SYComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}
-(void)addPhoto:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
    [_photos addObject:imageView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    int maxCol = 3;
    CGFloat photoWH = ([UIScreen mainScreen].bounds.size.width - 40) / 3;
    CGFloat photoMargin = 10;
    for (int i = 0; i < count; i ++) {
        UIImageView *photoView = self.subviews[i];
        int col = i % maxCol;
        int row = i / maxCol;
        CGFloat photoX = col * (photoWH + photoMargin);
        CGFloat photoY = row * (photoWH + photoMargin);
        CGFloat photoW = photoWH;
        CGFloat photoH = photoWH;
        photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
    }
}

//@property (nonatomic,strong) NSMutableArray *addedPhotos;

//- (NSMutableArray *)addedPhotos
//{
//    if (!_addedPhotos) {
////        self.addedPhotos = [[NSMutableArray alloc] init];
//        self.addedPhotos = [NSMutableArray array];
//    }
//    return _addedPhotos;
//}

//- (NSArray *)photos
//{
//    return self.addedPhotos;
//}
@end
