//
//  SYStatusFrame.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.

//  int rows = count /3;
//  if((count % 3)!= 0){
//      rows +=1;
//  }
//
//    int rows = 0;
//    if (count % 3 == 0) { // count = 3\6\9
//        rows = count / 3;
//    } else { // count = 1\2\4\5\7\8
//        rows = count / 3 + 1;
//    }

#import "SYStatusFrame.h"
#import "SYStatus.h"
#import "SYUser.h"
#import "NSString+SY.h"
#import "SYStatusPhotosView.h"

//上下cell之间的灰色间距
#define kSYStatusCellMargin 8

@implementation SYStatusFrame

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
    CGSize nameSize = [user.name sizeWithFont:kSYStatusCellNameFont];
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
    CGSize  timeSize = [status.created_at sizeWithFont:kSYStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + kSYStatusCellBorder;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:kSYStatusCellSourceFont];
    self.sourceLabelF =(CGRect){{sourceX,sourceY},sourceSize};
    
    //正文
    CGFloat contentX = iconViewX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF),CGRectGetMaxY(self.timeLabelF) ) + kSYStatusCellBorder;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat contentW = cellW - 2 * kSYStatusCellBorder
    ;
   
//    CGSize contentSize = [status.text sizeWithFont:kSYStatusCellContentFont maxW:contentW];
    CGSize contentSize = [status.attributedText boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    
    //配图
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGSize photosSize = [SYStatusPhotosView sizeWithCount:(int)status.pic_urls.count];
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + kSYStatusCellBorder;
        self.photosViewF = (CGRect){{contentX,photoY},photosSize};
        
        originalH = CGRectGetMaxY(self.photosViewF) + kSYStatusCellBorder;
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF) + kSYStatusCellBorder;
    }
    //原创微博整体
    self.originalViewF = CGRectMake(0, kSYStatusCellBorder, cellW,originalH);
    
    
    
    /* 被转发微博 */
    CGFloat toolbarY = 0;
    if (status.retweeted_status) {
        SYStatus *retweeted_status = status.retweeted_status;
        
        /** 被转发微博正文 */
        CGFloat retweetContentX = kSYStatusCellBorder;
        CGFloat retweetContentY = kSYStatusCellBorder;
        
        CGSize retweetContentSize = [status.retweeteAttributedText boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;

        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        /** 被转发微博配图 */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
            
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + kSYStatusCellBorder;
            CGSize retweetPhotosSize = [SYStatusPhotosView sizeWithCount:(int)retweeted_status.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotoX,retweetPhotoY},retweetPhotosSize};
            
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + kSYStatusCellBorder;
        } else { // 转发微博没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + kSYStatusCellBorder;
        }
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    //底部工具条
    
    self.toolbarF = CGRectMake(0, toolbarY, cellW, 35);
    
    
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
}

@end
