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
#import "SYTitleMenuViewController.h"
#import "SYAccountTool.h"
#import "SYTitleButton.h"
#import "UIImageView+WebCache.h"
#import "SYUser.h"
#import "SYStatus.h"
#import "MJExtension.h"
#import "SYLoadMoreFooter.h"
#import "SYStatusCell.h"
#import "SYStatusFrame.h"
#import "SYHttpTool.h"
#import "MJRefresh.h"
#import "SYStatusTool.h"
#import "SYHomeStatusesParam.h"
#import "SYHomeStatusesResult.h"
#import "SYStatusDetailViewController.h"


#define SYSpecialText @"SYSpecialText"
#define SYSpecialDidSelectedNotification  @"SYSpecialDidSelectedNotification"

@interface SYHomeViewController ()<SYDropdownmMenuDelegate>
/**
 *  微博数组（里面放的都是SYStatuFrame模型，一个模型就是一条微博,包含SYStatus数据和Frame）
 */
@property (nonatomic,strong) NSMutableArray *statusFrames;
@end

@implementation SYHomeViewController
/**
 *  懒加载
 */
-(NSMutableArray *)statusFrames{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
/**
 *  初始化控件
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"status.sqlite"];
    
    NSLog(@"path===%@",path);
    //导航栏信息设置
    [self setupNav];

    //设置用户信息
    [self setupUserInfo];
    
    //下拉刷新
    [self setDownRefresh];
    
    //上拉加载
    [self setUpRefresh];
    
    // 监听链接选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(specialDidSelected:) name:SYSpecialDidSelectedNotification object:nil];
    
    //获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    //主线程也会抽时间处理下timer
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
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
    
   
    //1.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SYAccount *account = [SYAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    //2.发送请求
    [SYHttpTool get:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(id json) {
        NSLog(@"json__%@",json);
        //取出名字
        SYUser *user = [SYUser objectWithKeyValues:json];
        //设置标题
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        //将名字存入沙盒
        account.name = user.name;
        [SYAccountTool saveAccount:account];
    } failure:^(NSError *error) {
           NSLog(@"请求失败 --%@",error);
    }];
    
     /**
     //1.请求管理者
     AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
     //3.发送请求
     [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
     }];
     */
   
}
/**
 *  添加下拉刷新控件
 */
-(void)setDownRefresh{
    
    [self.tableView addHeaderWithTarget:self action:@selector(refreshStateChange)];
    
    [self.tableView headerBeginRefreshing];
    /**
     UIRefreshControl *control = [[UIRefreshControl alloc] init];
     [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
     [self.tableView addSubview:control];
     //如果使用 [control beginRefresh] 仅仅是显示，不会触发UIControlEventValueChanged
     //进来就直接刷新一次
     [self refreshStateChange:control];
     
     */
  
}
/**
 *  下拉刷新，加载最新数据
 */
-(void)refreshStateChange{
//    //TODO: 本地测试数据
//    NSDictionary *responseObject = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fakeStatus" ofType:@".plist"]];
//    //取得字典数组,转换成模型数组
//    NSArray *newStatus = [SYStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"] ];
//    //将SYStatus模型转为SYStatusFrame模型
//    NSArray *statusFrames = [self statusFrameWithStatuses:newStatus];
//    
//    //将最新的数据添加到数组最前面
//    NSRange range = NSMakeRange(0, newStatus.count);
//    NSIndexSet *set = [[NSIndexSet alloc] initWithIndexesInRange:range];
//    [self.statusFrames insertObjects:statusFrames atIndexes:set];
//    
//    // 刷新表格
//    [self.tableView reloadData];
//    
//    //显示新的微博数量
//    [self showNewStatusCount:newStatus.count];
//    
//    
//    return;
    
    //2.拼接参数
    SYHomeStatusesParam *param = [[SYHomeStatusesParam alloc] init];
    SYAccount *account = [SYAccountTool account];
    param.access_token = account.access_token;
    SYStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    if (firstStatusFrame) {
        param.since_id = firstStatusFrame.status.idstr;
    }
    
//    [SYHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(id json) {
    //3.发送请求
    [SYStatusTool homeStatusesWithParam:param success:^(SYHomeStatusesResult *result) {
        //取得字典数组,转换成模型数组
//        NSArray *newStatus = [SYStatus objectArrayWithKeyValuesArray:json[@"statuses"] ];
        
        //将SYStatus模型转为SYStatusFrame模型数组
        NSArray *statusFrames = [self statusFrameWithStatuses:result.statuses];
        
        //将最新的数据添加到数组最前面
        NSRange range = NSMakeRange(0, statusFrames.count);
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndexesInRange:range];
        [self.statusFrames insertObjects:statusFrames atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView headerEndRefreshing];
        
        //显示新的微博数量
        [self showNewStatusCount:statusFrames.count];
    } failure:^(NSError *error) {
        NSLog(@"请求失败 --%@",error);
         [self.tableView headerEndRefreshing];
    }];
}
/**
 *  将SYStatus模型转为SYStatusFrame模型数组
 */
-(NSArray *)statusFrameWithStatuses:(NSArray *)statuses{
    NSMutableArray *statusFrames = [NSMutableArray array];
    for (SYStatus *status in statuses) {
        SYStatusFrame *statusFrame = [[SYStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrames addObject:statusFrame];
    }
    return statusFrames;
}
/**
 *  添加上拉加载控件
 */
-(void)setUpRefresh{
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
//    SYLoadMoreFooter *footer = [SYLoadMoreFooter footerView];
//    footer.hidden = YES;
//    self.tableView.tableFooterView = footer;
}
/**
 *  上拉加载，加载数据
 */
-(void)loadMoreStatus{
    //2.拼接参数
    SYHomeStatusesParam *param = [[SYHomeStatusesParam alloc] init];
    SYAccount *account = [SYAccountTool account];
    param.access_token = account.access_token;
     // 取出最后面的微博（最新的微博，ID最大的微博）
    SYStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    if (lastStatusFrame) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusFrame.status.idstr.longLongValue - 1;
        param.max_id = @(maxId);
    }
 
//    [SYHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(id json) {
    
    //3.发送请求
    [SYStatusTool homeStatusesWithParam:param success:^(SYHomeStatusesResult *result) {
        
        //取得字典数组,转换成模型数组
//        NSArray *newStatus = [SYStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        NSArray *statusFrames = [self statusFrameWithStatuses:result.statuses];
        
        //将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        [self.tableView footerEndRefreshing];
        //self.tableView.tableFooterView.hidden = YES;
    } failure:^(NSError *error) {
        NSLog(@"请求失败 --%@",error);
         [self.tableView footerEndRefreshing];
    }];
}

- (void)specialDidSelected:(NSNotification *)note{
    
    NSString *specialText = note.userInfo[SYSpecialText];
    if ([specialText hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:specialText]];
    }else{
        // 跳转控制器
        NSLog(@"选中了非HTTP链接---%@", note.userInfo[SYSpecialText]);
    }

}

/**
 *  获得未读数
 */
-(void)setupUnreadCount{
    // 2.拼接请求参数
    SYAccount *account = [SYAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [SYHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(id json) {
        // @20 --> @"20"
        // NSNumber --> NSString
        // 设置提醒数字(微博的未读数)
        NSString *status = [json[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            // 设置提醒数字,tabBar和用户手机桌面的badgeValue
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(NSError *error) {
            NSLog(@"请求失败-%@", error);
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
        label.text = @"没有最新的微博";
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
    return self.statusFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获得cell
    SYStatusCell *cell = [SYStatusCell cellWithTableView:tableView];
    
    //给cell传递模型数据
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    /**
     *  
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
     */
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

#pragma mark - tableView 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    SYStatusDetailViewController *detail = [[SYStatusDetailViewController alloc] init];
//    SYStatusFrame *statusFrame = self.statusFrames[indexPath.row];
//    detail.status = statusFrame.status;
//    detail.statusFrame = statusFrame;
//    [self.navigationController pushViewController:detail animated:YES];
    
    
    
}
#pragma mark - UIScrollView的代理方法  配合 上拉加载控件使用
//  因为使用了MJRefresh，所以没有必要再监听tableView的滑动（到下面刷新）
/*
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //scrollView == self.tableView == self.view
    //如果tableView还没有数据，直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
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
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
}
*/

@end
