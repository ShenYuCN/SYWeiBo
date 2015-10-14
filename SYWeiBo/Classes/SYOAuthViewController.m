//
//  SYOAuthViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/10/14.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYOAuthViewController.h"
#import "AFNetworking.h"
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
    
    if (range.length != 0) {
        int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        NSLog(@"%@",code);
        [self accessTokenWithCode:code];
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
     *  请求参数
     必选	类型及范围	说明
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     

     */
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer= [AFJSONResponseSerializer serializer]
    
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"]     = @"2543107217";
    params[@"client_secret"] = @"07137f4afb2e451a9728e3f447771689";
    params[@"grant_type"]    = @"authorization_code";
    params[@"code"]          = code;
    params[@"redirect_uri"]  = @"http://";
    
    
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功----%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败 ---- %@",error);
    }];
}
@end
