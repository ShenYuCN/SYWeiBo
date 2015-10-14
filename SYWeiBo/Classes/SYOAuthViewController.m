//
//  SYOAuthViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/14.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "SYAccount.h"
#import "SYTabBarViewController.h"
#import "SYNewFeatureViewController.h"
@interface SYOAuthViewController()<UIWebViewDelegate>
@end
@implementation SYOAuthViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = self.view.frame;
    [self.view addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2543107217&redirect_uri=http://"]];
    [webView loadRequest:request];
    
}
#pragma mark - 代理方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request.URL);
    //获取code
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    
    //判断是否为回调地址
    if (range.length != 0) {
        int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        NSLog(@"%@",code);
        [self accessTokenWithCode:code];
        // 禁止加载回调地址
        return NO;
    }
    return YES;
}

/**
 *  利用code(授权成功获得的Request token) 换取一个AccessToken
 *
 *  @param code 授权成功获得的Request token
 */
-(void)accessTokenWithCode:(NSString *)code{

    /**
     https://api.weibo.com/oauth2/access_token
     client_id	  申请应用时分配的AppKey。
     client_secret申请应用时分配的AppSecret。
     grant_type	  请求的类型，填写authorization_code
     code		  调用authorize获得的code值。
     redirect_uri 回调地址，需需与注册应用里的回调地址一致。
     */
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"]     = @"2543107217";
    params[@"client_secret"] = @"07137f4afb2e451a9728e3f447771689";
    params[@"grant_type"]    = @"authorization_code";
    params[@"code"]          = code;
    params[@"redirect_uri"]  = @"http://";
    
    
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"请求成功----%@",responseObject);
        [MBProgressHUD hideHUD];
        
        
        //将数据字典转成模型，存进沙盒
        NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [document stringByAppendingPathComponent:@"account.archive"];
        
        // 自定义对象的存储必须用NSKeyedArchiver，内部调用encodeWithCoder
        SYAccount *account = [SYAccount accountWithDict:responseObject];
        [NSKeyedArchiver archiveRootObject:account toFile:path];
        
        
        // 切换窗口的根控制器
        NSString *key = @"CFBundleVersion";
        // 上一次的使用版本（存储在沙盒中的版本号）在模拟器(手机上)的Library/Preferences偏好设置
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        // 当前软件的版本号（从Info.plist中获得)本地电脑上项目中的plist文件中
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
            window.rootViewController = [[SYTabBarViewController alloc] init];
        } else { // 这次打开的版本和上一次不一样，显示新特性
            window.rootViewController = [[SYNewFeatureViewController alloc] init];
            
            // 将当前的版本号存进沙盒`
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败 ---- %@",error);
        [MBProgressHUD hideHUD];
    }];
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
@end
