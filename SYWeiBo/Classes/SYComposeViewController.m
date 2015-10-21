//
//  SYComposeViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/20.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYComposeViewController.h"
#import "SYAccountTool.h"
#import "UIView+Extension.h"
#import "SYTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
@interface SYComposeViewController ()
@property (nonatomic,weak) SYTextView *textView;
@end

@implementation SYComposeViewController
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    [self setupNav];
    
    //设置输入控件
    [self setupTextView];

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
    viewDidLoad是懒加载，用的时候调用，
    可能在viewDidLoad之前被调用，导致主题无法显示，那么创建view的时候得不到SYNavigationController的主题样式
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
#pragma mark - 初始化方法
/**
 *  设置导航栏
 */
-(void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
//    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor redColor];
//    [item setTitleTextAttributes:dict forState:UIControlStateDisabled];
//    [item setTintColor:[UIColor redColor]];
//    self.navigationItem.rightBarButtonItem = item;
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.height = 60;
    titleLabel.width = 200;
//    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    
    NSString *prefix = @"发微博";
    NSString *name = [SYAccountTool account].name ;
    NSString *newStr= [NSString stringWithFormat:@"%@\n%@",prefix,name];
    if (name) {
        //创建一个带属性的字符串
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:newStr];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[newStr rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[newStr rangeOfString:name]];
        
        titleLabel.attributedText = attrStr;
        self.navigationItem.titleView = titleLabel;
    }else{
        self.title = prefix;
    
    }
    
}
/**
 *  设置输入控件
 */
-(void)setupTextView{
    
    SYTextView *textView = [[SYTextView alloc] init];
    textView.frame = self.view.bounds;
//    textView.placeHolderColor = [UIColor redColor];
    textView.placeHolder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:textView];
    
}
#pragma mark - 监听方法
-(void)textDidChanged{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)send{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SYAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
