//
//  SYOAuthViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/14.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "SYAccount.h"
#import "SYTabBarViewController.h"
#import "SYNewFeatureViewController.h"
#import "SYAccountTool.h"
#import "UIWindow+Extension.h"
#import "SYConst.h"
#import "SYHttpTool.h"


@interface SYOAuthViewController()<UIWebViewDelegate>
@end
@implementation SYOAuthViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = self.view.frame;
    [self.view addSubview:webView];
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",SYAppKey,SYRedirectURI];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [webView loadRequest:request];
    
}
#pragma mark - 代理方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //获取code
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    
    //判断是否为回调地址
    if (range.length != 0) {
        int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
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
    
    
    //1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"]     = SYAppKey;
    params[@"client_secret"] = SYAppSecret;
    params[@"grant_type"]    = @"authorization_code";
    params[@"code"]          = code;
    params[@"redirect_uri"]  = SYRedirectURI;
    
    
    //2.发送请求
    [SYHttpTool post:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(id json) {
        [MBProgressHUD hideHUD];
        
        // 将返回的账号字典数据 --> 模型，存进沙盒
        SYAccount *account = [SYAccount accountWithDict:json];
        // 存储账号信息
        [SYAccountTool saveAccount:account];
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    } failure:^(NSError *error) {
        NSLog(@"请求失败 ---- %@",error);
        [MBProgressHUD hideHUD];
    }];
    
    /**
     //1.请求管理者
     AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
     
     //3.发送请求
     [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
     }];
     */
   
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
