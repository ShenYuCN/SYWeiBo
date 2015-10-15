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
@interface SYHomeViewController ()<SYDropdownmMenuDelegate>
@end

@implementation SYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏左右按钮
    [self setupNav];

    //设置用户信息
    [self setupUserInfo];
    
   
    
}

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
        NSLog(@"请求成功---%@",responseObject);
        //取出名字
        NSString *name = responseObject[@"name"];
        //设置标题
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:name forState:UIControlStateNormal];
        //将名字存入沙盒
        account.name = name;
        [SYAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败 --%@",error);
    }];
}

/**
 *  设置顶部按钮
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
@end
