//
//  SYStatusFrame.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYStatusFrame.h"
#import "SYStatus.h"
#import "SYUser.h"

#define kSYStatusCellBorder 10
@implementation SYStatusFrame
/**
 *  计算文字尺寸
 *
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
-(CGSize) sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = kSYStatusCellNameFont;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(CGSize) sizeWithText:(NSString *)text font:(UIFont *)font{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}
-(void)setStatus:(SYStatus *)status{
    _status = status;
    SYUser *user = status.user;
    
    
    //头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = kSYStatusCellBorder;
    CGFloat iconViewY = iconViewX;
    self.iconViewF =CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //昵称
    CGFloat nameLabelX = CGRectGetMaxX(self.iconViewF) + kSYStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameSize = [self sizeWithText:user.name font:kSYStatusCellNameFont];
    self.nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameSize.width, nameSize.height);
    
    //会员图标
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + kSYStatusCellBorder;
        CGFloat vipY =  nameLabelY;
        CGFloat vipH = nameSize.height;
         CGFloat vipW = vipH;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
   
    //时间
    CGFloat timeX = nameLabelX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + kSYStatusCellBorder;
    CGSize  timeSize = [self sizeWithText:status.created_at font:kSYStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + kSYStatusCellBorder;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:kSYStatusCellSourceFont];
    self.sourceLabelF =(CGRect){{sourceX,sourceY},sourceSize};
    
    //正文
    CGFloat contentX = iconViewX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF),CGRectGetMaxY(self.timeLabelF) ) + kSYStatusCellBorder;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat contentW = cellW - 2 * kSYStatusCellBorder
    ;
    CGSize contentSize = [self sizeWithText:status.text font:kSYStatusCellContentFont maxW:contentW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    
    //配图
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photoWH = 100;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF);
        self.photoViewF = CGRectMake(contentX, photoY, photoWH, photoWH);
        originalH = CGRectGetMaxY(self.photoViewF) + kSYStatusCellBorder;
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF) + kSYStatusCellBorder;
    }
  
    
    //原创微博整体
    self.originalViewF = CGRectMake(0, 0, cellW,originalH);
    
    self.cellHeightF = CGRectGetMaxY(self.originalViewF);
}

@end
