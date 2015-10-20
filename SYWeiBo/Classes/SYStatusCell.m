//
//  SYStatusCell.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYStatusCell.h"
#import "SYStatus.h"
#import "SYUser.h"
#import "SYStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "SYPhoto.h"
#import "SYStatusToolBar.h"
@interface SYStatusCell()
/**原创微博整体*/
@property (nonatomic,weak) UIView *originalView;
/**头像*/
@property (nonatomic,weak) UIImageView *iconView;
/**配图*/
@property (nonatomic,weak) UIImageView *photoView;
/**会员图标*/
@property (nonatomic,weak) UIImageView *vipView;
/** 昵称 */
@property (nonatomic,weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic,weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic,weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic,weak) UILabel *contentLabel;


/** 转发微博整体 */
@property (nonatomic,weak) UIView *retweetView;
/** 转发微博正文（@+昵称+正文） */
@property (nonatomic,weak) UILabel *retweetContentLabel;
/** 转发微博配图 */
@property (nonatomic,weak) UIImageView *retweetPhotoView;


/** 工具条 */
@property (nonatomic,weak) SYStatusToolBar *toolbar;
@end


@implementation SYStatusCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    SYStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SYStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化，一个cell只会调一次
 *  添加子控件，并且对子控件一次性的设置
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //设置cell选中效果
        //无效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //其他颜色
//        UIView *selectedViewBg = [[UIView alloc] init];
//        selectedViewBg.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//        self.selectedBackgroundView =selectedViewBg;
        
        
        
        //初始化原创微博
        [self setupOriginal];
        
        //初始化转发微博
        [self setupRetweet];
        
        //初始化工具条
        [self setupToolbar];
    }
    return  self;
}
/**
 *  初始化工具条
 */
-(void)setupToolbar{
    SYStatusToolBar *toolbar = [SYStatusToolBar toolbar];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}
/**
 *  初始化原创微博
 */
-(void)setupOriginal{
    /**原创微博整体*/
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    originalView.backgroundColor = [UIColor whiteColor];
    self.originalView = originalView;
    
    /**头像*/
    UIImageView *iconView = [[UIImageView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /**配图*/
    UIImageView *photoView = [[UIImageView alloc] init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
    
    /**会员图标*/
    UIImageView *vipView = [[UIImageView alloc] init];
    [originalView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    timeLabel.font = kSYStatusCellTimeFont;
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [originalView addSubview:sourceLabel];
    sourceLabel.font = kSYStatusCellSourceFont;
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    [originalView addSubview:contentLabel];
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    contentLabel.font = kSYStatusCellContentFont;
}
/**
 *  初始化转发微博
 */
-(void)setupRetweet{
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor =[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博正文 + 昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = kSYStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 *  设置frame，并塞数据
 */
-(void)setStatusFrame:(SYStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    SYStatus *status = statusFrame.status;
    SYUser *user = status.user;
    
    
    /**原创微博整体*/
    self.originalView.frame = statusFrame.originalViewF;
    
    /**头像*/
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /**配图*/
    if (status.pic_urls.count) {
        self.photoView.frame = statusFrame.photoViewF;
        SYPhoto *photo = [status.pic_urls lastObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }
  
    
    /**会员图标*/
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    self.nameLabel.font = kSYStatusCellNameFont;
    
    /** 时间 */
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = status.created_at;
    
    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = status.source;
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
   /** 被转发的微博 */
    if (status.retweeted_status) {
        self.retweetView.hidden = NO;
        SYStatus *retweetStatus = status.retweeted_status;
        SYUser *retweetUser = retweetStatus.user;
        
        /** 转发微博整体 */
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 转发微博正文（@+昵称+正文） */
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweetUser.name,retweetStatus.text];
        self.retweetContentLabel.text = retweetContent;
        
        /** 转发微博配图 */
        if (retweetStatus.pic_urls.count) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            SYPhoto *photo = [retweetStatus.pic_urls lastObject];
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        }else{
            self.retweetPhotoView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    
    //底部工具条
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
    
    
}
@end
