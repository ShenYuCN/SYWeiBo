//
//  SYStatusDetailView.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/20.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYStatusFrame;
@interface SYStatusDetailView : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) SYStatusFrame *statusFrame;
@end
