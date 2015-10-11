//
//  SYMessageCenterViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYMessageCenterViewController.h"
#import "Test1ViewController.h"
@interface SYMessageCenterViewController ()

@end

@implementation SYMessageCenterViewController

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test ----- %d",indexPath.row];
    
    return cell;

}
#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Test1ViewController *test1 = [[Test1ViewController alloc] init];
    test1.title = @"测试11";
    NSLog(@"didSelectedRowAtIndexPath --- %@",self.navigationController);
    [self.navigationController pushViewController:test1 animated:YES];
    

}
@end
