//
//  SYDiscoverViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYDiscoverViewController.h"
#import "UIView+Extension.h"
#import "SYSearchBar.h"
#import "SYCommonItem.h"
#import "SYCommonCell.h"
#import "SYCommonGroup.h"
#import "SYCommonSwitchItem.h"
#import "SYCommonArrowItem.h"
#import "SYCommonLabelItem.h"
@interface SYDiscoverViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray *groups;

@end

@implementation SYDiscoverViewController
-(NSMutableArray *)groups{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建搜索框对象
    UITextField *searchBar = [SYSearchBar searchBar];
    searchBar.size = CGSizeMake(300, 30);
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    //初始化模型
    [self setupGroups];
}
/**
 *  初始化模型数据
 */
- (void)setupGroups{
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}
- (void)setupGroup0{
    // 3.设置组的所有行数据
    SYCommonItem *hotStatus = [SYCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subTitle = @"笑话，娱乐，神最右都搬到这啦";
    
    SYCommonItem *findPeople = [SYCommonArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.subTitle = @"名人、有意思的人尽在这里";
    
    // 1.创建组
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的基本数据
    group.header = @"第0组头部";
    group.footer = @"第0组尾部的详细信息";
    
    group.items = @[hotStatus, findPeople];
}
- (void)setupGroup1{
    // 1.创建组
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SYCommonArrowItem *gameCenter = [SYCommonArrowItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    SYCommonItem *near = [SYCommonItem itemWithTitle:@"周边" icon:@"near"];
    SYCommonSwitchItem *app = [SYCommonSwitchItem itemWithTitle:@"应用" icon:@"app"];
    
    group.items = @[gameCenter, near, app];
}
- (void)setupGroup2{
    
    // 1.创建组
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SYCommonLabelItem *video = [SYCommonLabelItem itemWithTitle:@"视频" icon:@"video"];
    video.text = @"这是右边的文字";
    SYCommonItem *music = [SYCommonItem itemWithTitle:@"音乐" icon:@"music"];
    SYCommonItem *movie = [SYCommonItem itemWithTitle:@"电影" icon:@"movie"];
    movie.badgeValue = @"111";
    SYCommonItem *cast = [SYCommonItem itemWithTitle:@"播客" icon:@"cast"];
    cast.badgeValue = @"3";
    SYCommonItem *more = [SYCommonItem itemWithTitle:@"更多" icon:@"more"];
    
    group.items = @[video, music, movie, cast, more];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return  YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.groups[section] items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
@end
