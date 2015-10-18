//
//  SYStatusCell.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYStatusFrame;
/**
 *  首页微博的Cell
 */
@interface SYStatusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) SYStatusFrame *statusFrame;
@end
