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
#import "SYComposeToolbar.h"
@interface SYComposeViewController ()<UITextViewDelegate>
@property (nonatomic,weak) SYTextView *textView;
@property (nonatomic,strong) SYComposeToolbar *toolbar;
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
    
    //设置工具条
    [self setupToolbar];

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
    textView.placeHolder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:14];
    // 垂直方向上永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:textView];
    
    // 键盘通知
    // 键盘的frame发生改变时发出的通知（位置和尺寸）
    //    UIKeyboardWillChangeFrameNotification
    //    UIKeyboardDidChangeFrameNotification
    // 键盘显示时发出的通知
    //    UIKeyboardWillShowNotification
    //    UIKeyboardDidShowNotification
    // 键盘隐藏时发出的通知
    //    UIKeyboardWillHideNotification
    //    UIKeyboardDidHideNotification
    
    //对于键盘的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
-(void)setupToolbar{
    SYComposeToolbar *toolbar = [[SYComposeToolbar alloc] init];
    toolbar.height = 44;
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    //inputAccessoryView设置显示在键盘顶部的内容,inputView显示键盘
    //如果没有要求，退出键盘后toolbar也隐藏，则这局代码完全可以实现
//    self.textView.inputAccessoryView = toolbar;
    
    
    self.toolbar = toolbar;
    [self.view addSubview:toolbar];
}

#pragma mark - UITextView代理方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark - 监听方法
/**
 *  键盘frame改变时的监听
 */
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo);
    /**
     notification.userInfo = @{
     // 键盘弹出\隐藏后的frame
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 352}, {320, 216}},
     // 键盘弹出\隐藏所耗费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     // 键盘弹出\隐藏动画的执行节奏（先快后慢，匀速）
     UIKeyboardAnimationCurveUserInfoKey = 7
     }
     */
    NSDictionary *dict = notification.userInfo;
    double duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
    }];

}
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
