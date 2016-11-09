

//
//  SYProfileViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYProfileViewController.h"
#import "SYCommonGroup.h"
#import "SYCommonArrowItem.h"
#import "MBProgressHUD+MJ.h"
#import "SYSettingViewController.h"
#import "Test1ViewController.h"
@interface SYProfileViewController ()
@end

@implementation SYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 右上角的设置按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    
    // 初始化数据
    [self setupGroup];
}
- (void)setupGroup{
    [self setupGroup0];
    [self setupGroup1];

}
- (void)setupGroup0{
    
    // 1.创建组
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SYCommonArrowItem *newFriend = [SYCommonArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];
    newFriend.badgeValue = @"5";
    newFriend.operation = ^{
        [MBProgressHUD showSuccess:@"这是好友"];
    };
    group.items = @[newFriend];
    
}
- (void)setupGroup1{
    // 1.创建组
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SYCommonArrowItem *album = [SYCommonArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.subTitle = @"(100)";
    album.operation = ^{
        [MBProgressHUD showSuccess:@"这是相册"];
    };
    
    SYCommonArrowItem *collect = [SYCommonArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    collect.subTitle = @"(10)";
    collect.badgeValue = @"1";
    
    SYCommonArrowItem *like = [SYCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    like.subTitle = @"(36)";
    like.badgeValue = @"10";
    
    group.items = @[album, collect, like];
}
-(void)setting{
    SYSettingViewController *setting = [[SYSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

@end
