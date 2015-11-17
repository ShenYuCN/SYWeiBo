//
//  SYCommonCell.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/17.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYCommonItem;
@interface SYCommonCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSUInteger)rows;
/** cell的一行数据模型 */
@property (nonatomic,strong) SYCommonItem *item;
@end
