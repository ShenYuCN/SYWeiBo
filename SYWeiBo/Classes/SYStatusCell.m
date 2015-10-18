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
 *  在这里设置添加子控件，并且对子控件一次性的设置
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /**原创微博整体*/
        UIView *originalView = [[UIView alloc] init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        /**头像*/
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.originalView addSubview:iconView];
        self.iconView = iconView;
        
        /**配图*/
        UIImageView *photoView = [[UIImageView alloc] init];
        [self.originalView addSubview:photoView];
        self.photoView = photoView;
        
        /**会员图标*/
        UIImageView *vipView = [[UIImageView alloc] init];
        [self.originalView addSubview:vipView];
        self.vipView = vipView;
        
        /** 昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        [self.originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        [self.originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self.originalView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 正文 */
        UILabel *contentLabel = [[UILabel alloc] init];
        [self.originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return  self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
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
    self.photoView.frame = statusFrame.photoViewF;
    self.photoView.backgroundColor = [UIColor redColor];
    
    /**会员图标*/
    self.vipView.frame = statusFrame.vipViewF;
    self.vipView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLavelF;
    self.nameLabel.text = user.name;
    
    /** 时间 */
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
}
@end
