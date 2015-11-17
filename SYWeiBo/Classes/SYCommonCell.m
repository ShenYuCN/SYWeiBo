//
//  SYCommonCell.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/17.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYCommonCell.h"
#import "SYCommonItem.h"
#import "UIView+Extension.h"
#import "UIImage+SY.h"
@implementation SYCommonCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"common";
    SYCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SYCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;

}
/**
 * cell的初始化，一个cell只会调一次
 * 添加子控件，并且对子控件一次性的设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置标题字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont boldSystemFontOfSize:13];
        
        //取出默认的cell颜色
        self.backgroundColor = [UIColor clearColor];
        
        //设置背景
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        
    }
    return self;
}

#pragma mark - 调整subTitle的位置
- (void)layoutSubviews{
    [super layoutSubviews];
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
}
#pragma mark - 设置分割线
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSUInteger)rows{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    if (rows == 1) {//只有一行
        bgView.image = [UIImage resizableImage:@"common_card_background"];
        selectedBgView.image = [UIImage resizableImage:@"common_card_background_highlighted"];
    }else if (indexPath.row == 0){//第一行
        bgView.image = [UIImage resizableImage:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizableImage:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage resizableImage:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizableImage:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage resizableImage:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizableImage:@"common_card_middle_background_highlighted"];
    }
}

#pragma mark - setter方法设置item
-(void)setItem:(SYCommonItem *)item{
    _item = item;
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
}

@end
