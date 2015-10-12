//
//  SYTitleMenuViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/12.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYTitleMenuViewController.h"

@implementation SYTitleMenuViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"朋友";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"女朋友";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"男朋友";
    }


    
    return cell;

}
@end
