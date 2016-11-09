//
//  SYCommonViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYCommonViewController.h"
#import "SYDiscoverViewController.h"
#import "UIView+Extension.h"
#import "SYSearchBar.h"
#import "SYCommonItem.h"
#import "SYCommonCell.h"
#import "SYCommonGroup.h"
#import "SYCommonSwitchItem.h"
#import "SYCommonArrowItem.h"
#import "SYCommonLabelItem.h"
#import "SYOneTempController.h"
#define SYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation SYCommonViewController
-(NSMutableArray *)groups{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}
/**
 *  初始化tableView的样式，group还是plain
 */
- (instancetype)init{
    return  [super initWithStyle:UITableViewStyleGrouped];
}
/**
 *  初始化tableView的样式，group还是plain
 */
-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView属性
    self.tableView.backgroundColor = SYColor(211,211,211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(10 - 35, 0, 0, 0);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.groups[section] items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell,并给cell传递模型
    SYCommonCell *cell = [SYCommonCell cellWithTableView:tableView];
    SYCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    // 设置cell所处的行号 和 所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    SYCommonGroup *group = self.groups[section];
    return group.header;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    SYCommonGroup *group = self.groups[section];
    return group.footer;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消选中这行，取消灰色显示
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // 1.取出这行对应的item模型
    SYCommonGroup *group = self.groups[indexPath.section];
    SYCommonItem *item = group.items[indexPath.row];
    
    // 2.判断有没有要跳转的控制器
    if (item.destVc) {
        UIViewController *destVc = [[item.destVc alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有没有要执行的block
    if (item.operation) {
        item.operation();
    }
}
@end
