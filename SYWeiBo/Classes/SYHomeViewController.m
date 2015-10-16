//
//  SYHomeViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/10.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "SYDropdownMenu.h"
#import "AFNetworking.h"
#import "SYTitleMenuViewController.h"
#import "SYAccountTool.h"
#import "SYTitleButton.h"
#import "UIImageView+WebCache.h"
#import "SYUser.h"
#import "SYStatus.h"
#import "MJExtension.h"
#import "SYLoadMoreFooter.h"
@interface SYHomeViewController ()<SYDropdownmMenuDelegate>
/**
 *  微博数组（里面放的都是SYStatus模型，一个模型就是一条微博）
 */
@property (nonatomic,strong) NSMutableArray *statuses;
@end

@implementation SYHomeViewController
-(NSMutableArray *)statuses{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏信息设置
    [self setupNav];

    //设置用户信息
    [self setupUserInfo];
    
    //下拉刷新
    [self setDownRefresh];
    
    //上拉加载
    [self setUpRefresh];
    
    
}

/**
 *  设置用户信息
 */
-(void)setupUserInfo{
    
    /**
     access_token采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid 需要查询的用户ID。
     https://api.weibo.com/2/users/show.json
     */
    
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SYAccount *account = [SYAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //取出名字
        SYUser *user = [SYUser objectWithKeyValues:responseObject];
        //设置标题
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        //将名字存入沙盒
        account.name = user.name;
        [SYAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败 --%@",error);
    }];
}
/**
 *  添加下拉刷新控件
 */
-(void)setDownRefresh{
    
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    //如果使用 [control beginRefresh] 仅仅是显示，不会触发UIControlEventValueChanged
    //进来就直接刷新一次
    [self refreshStateChange:control];
}
/**
 *  UIRefreshControl进入刷新状态：下拉刷新，加载最新数据
 */
-(void)refreshStateChange:(UIRefreshControl *)control{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SYAccount *account = [SYAccountTool account];
    params[@"access_token"] = account.access_token;
    SYStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        params[@"since_id"] = firstStatus.idstr;
    }
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
         [control endRefreshing];
        NSLog(@"%@",responseObject);
        //取得字典数组,转换成模型数组
        NSArray *newStatus = [SYStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"] ];
        //将最新的数据添加到数组最前面
        NSRange range = NSMakeRange(0, newStatus.count);
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndexesInRange:range];
        [self.statuses insertObjects:newStatus atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        [control endRefreshing];
        
        //显示新的微博数量
        [self showNewStatusCount:newStatus.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败 --%@",error);
        [control endRefreshing];
    }];
}
/**
 *  添加上拉加载控件
 */
-(void)setUpRefresh{
    SYLoadMoreFooter *footer = [SYLoadMoreFooter footerView];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}
/**
 *  上拉加载，加载数据
 */
-(void)loadMoreStatus{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SYAccount *account = [SYAccountTool account];
    params[@"access_token"] = account.access_token;
     // 取出最后面的微博（最新的微博，ID最大的微博）
    SYStatus *lastStatus = [self.statuses lastObject];
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //取得字典数组,转换成模型数组
        NSArray *newStatus = [SYStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"] ];
        
        //将更多的微博数据，添加到总数组的最后面
        [self.statuses addObjectsFromArray:newStatus];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败 --%@",error);
      self.tableView.tableFooterView.hidden = YES;
    }];
}
/**
 *  显示新的微博数量
 */
-(void)showNewStatusCount:(NSInteger)count{
    UILabel *label = [[UILabel alloc] init];
    //设置frame
    label.height = 30;
    label.width  = [UIScreen mainScreen].bounds.size.width;
    label.y      = 64 -label.height;
    
    //设置属性
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    if (count == 0) {
        label.text = @"没有最新的微博，请稍后重试";
    }else{
        label.text = [NSString stringWithFormat:@"%ld条新微博",count];
    }
    //添加到视图
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //添加动画
    [UIView animateWithDuration:0.5 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}

/**
 *  导航栏信息设置
 */
-(void)setupNav{
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    
    //导航栏中间
    SYTitleButton *titleBtn = [[SYTitleButton alloc] init];
    //设置图片和文字
    NSString *name = [[SYAccountTool account] name];
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

/**
 *  标题栏TitleView的点击设置
 */
-(void)titleClick:(UIButton *)titleButton{
    //创建一个下拉菜单
    SYDropdownMenu *menu = [SYDropdownMenu menu];
    
    //设置代理
    menu.delegate = self;
    
    SYTitleMenuViewController *vc = [[SYTitleMenuViewController alloc] init];
    vc.view.height = 44 * 3;
    vc.view.width = 150;
    menu.contentController = vc;
    //显示
    [menu showFrom:titleButton];
}

-(void)back{
    NSLog(@"back");
}

-(void)more{
    NSLog(@"more");
}
#pragma mark - SYDropdownmMenuDelegate的代理方法
/**
 *  菜单销毁了
 */
-(void)dropdownMenuDidDismiss:(SYDropdownMenu *)menu{
     // 让箭头向下
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = NO;
    
}
/**
 *  下拉菜单显示了
 */
-(void)dropdownMenuDidShow:(SYDropdownMenu *)menu{
     // 让箭头向上 selected --- up
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = YES;
}
#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.statuses.count;
    return self.statuses.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    //取出这行微博字典
    SYStatus *status = self.statuses[indexPath.row];
    //设置微博的文字
    cell.detailTextLabel.text = status.text;
    //取出这条微博的作者
    SYUser *user = status.user;
    cell.textLabel.text = user.name;
    //设置头像
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placeholderImage];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //scrollView == self.tableView == self.view
    //如果tableView还没有数据，直接返回
    if (self.statuses.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    
    if (offsetY >= judgeOffsetY ) {
        //最后一个cell进入视野范围内
        //显示footer
        self.tableView.tableFooterView.hidden = NO;
        //加载更多数据
        [self loadMoreStatus];
    }
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}
@end
