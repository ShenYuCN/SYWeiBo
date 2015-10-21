//
//  SYComposePhotoView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/21.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYComposePhotosView.h"

@implementation SYComposePhotosView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)addPhoto:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    int maxCol = 3;
    CGFloat photoWH = 90;
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

@end
