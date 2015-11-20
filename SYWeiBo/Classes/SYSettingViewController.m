//
//  SYSettingViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/19.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYSettingViewController.h"
#import "SYCommonGroup.h"
#import "SYCommonArrowItem.h"
#import "UIImage+SY.h"
#import "SYGeneralSettingViewController.h"
#import "UIView+Extension.h"
@interface SYSettingViewController ()

@end

@implementation SYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFooter];
    [self setupGroup];
}


- (void)setupFooter
{
    // 1.创建按钮
    UIButton *logout = [[UIButton alloc] init];
    
    // 2.设置属性
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizableImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizableImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    logout.height = 35;
    
    self.tableView.tableFooterView = logout;
}
- (void)setupGroup{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0{
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    group.footer = @"账号管理的设置";
    SYCommonArrowItem *accountMgr = [SYCommonArrowItem itemWithTitle:@"账号管理"];
    group.items = @[accountMgr];
}
- (void)setupGroup1{
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    SYCommonArrowItem *theme = [SYCommonArrowItem itemWithTitle:@"主题背景"];
    group.items = @[theme];
}
- (void)setupGroup2{
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    group.header = @"通用设置,清除缓存";
    SYCommonArrowItem *commonSet = [SYCommonArrowItem itemWithTitle:@"通用设置"];
    commonSet.destVc = [SYGeneralSettingViewController class];
    group.items = @[commonSet];
}
@end
