//
//  SYStatusDetailViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYStatusDetailViewController.h"
#import "SYStatusCell.h"
#import "UIView+Extension.h"
#import "SYStatusDetailView.h"
// RGB颜色
#define SYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface SYStatusDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation SYStatusDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博正文";
    self.view.backgroundColor = [UIColor grayColor];
    
    // 创建tableView
    [self setupTableView];
    
    // 创建微博详情控件
    [self setupDetailView];
}

/**
 *  创建tableView
 */
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.width = self.view.width;
    tableView.height = self.view.height - 35;
    tableView.backgroundColor = SYColor(211, 211, 211);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)setupDetailView{
    
    SYStatusDetailView *cell = [[SYStatusDetailView alloc] init];
    
    
    //获得cell
    
    //给cell传递模型数据
    cell.statusFrame = self.statusFrame;
    
//    // 创建微博详情控件
//    HMStatusDetailView *detailView = [[HMStatusDetailView alloc] init];
//    // 创建frame对象
//    HMStatusDetailFrame *detailFrame = [[HMStatusDetailFrame alloc] init];
//    self.status.retweeted_status.detail = YES;
//    detailFrame.status = self.status;
//    // 传递frame数据
//    detailView.detailFrame = detailFrame;
//    // 设置微博详情的高度
//    detailView.height = detailFrame.frame.size.height;
    
    
    self.tableView.tableHeaderView = cell;

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = @"ddd";
    return cell;
}

@end
