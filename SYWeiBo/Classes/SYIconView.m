//
//  SYIconView.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/20.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYIconView.h"
#import "UIImageView+WebCache.h"
#import "SYUser.h"
#import "UIView+Extension.h"
@interface SYIconView()
@property(nonatomic,weak) UIImageView *verifiedView;
@end

@implementation SYIconView

-(UIImageView *)verifiedView{

    if (_verifiedView == nil) {
        UIImageView  *verifiedView= [[UIImageView alloc] init];
        self.verifiedView = verifiedView;
        [self addSubview:verifiedView];
    }
    return _verifiedView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setUser:(SYUser *)user{
    _user = user;
    //1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
     // 2.设置加V图片
    switch (user.verified_type) {
        case SYUserVerifiedTypeNone: // 无认证 -1
            break;
        case SYUserVerifiedTypeNonePerson: // 无认证 1
            break;
        case SYUserVerifiedPersonal: // 个人认证 0
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case SYUserVerifiedOrgEnterprice: // 企业官方：CSDN、EOE、搜狐新闻客户端 2
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case SYUserVerifiedOrgMedia:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case SYUserVerifiedOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case SYUserVerifiedDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES; // 当做没有任何认证
            break;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
   

}
@end
