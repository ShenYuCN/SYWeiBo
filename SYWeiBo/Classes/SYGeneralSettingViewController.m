//
//  SYGeneralSettingViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/19.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYGeneralSettingViewController.h"
#import "SYCommonGroup.h"
#import "SYCommonLabelItem.h"
#import "SDImageCache.h"
#import "NSString+File.h"
#import "SYCommonArrowItem.h"
#import "MBProgressHUD+MJ.h"
@interface SYGeneralSettingViewController ()

@end

@implementation SYGeneralSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGroups];
}
/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    // 1.创建组
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SYCommonLabelItem *readMdoe = [SYCommonLabelItem itemWithTitle:@"阅读模式"];
    readMdoe.text = @"有图模式";
    
    group.items = @[readMdoe];
}

- (void)setupGroup1
{
    // 1.创建组
    SYCommonGroup *group = [SYCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SYCommonLabelItem *clearCache = [SYCommonLabelItem itemWithTitle:@"清除图片缓存"];
    
    // 设置缓存的大小
    //    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    [caches stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    NSString *imageCachePath = [[SDImageCache sharedImageCache] diskCachePath];
    NSLog(@"%@",imageCachePath);
    long long fileSize = [imageCachePath fileSize];
    clearCache.text = fileSize == 0 ? nil : [NSString stringWithFormat:@"%.1fM",fileSize / (1000.0 * 1000.0)] ;
    
    __weak typeof(clearCache) weakClearCache = clearCache;
    __weak typeof(self) weakVc = self;
    clearCache.operation = ^{
        [MBProgressHUD showMessage:@"正在清除缓存...."];
        
        // 清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:imageCachePath error:nil];
        
        // 设置subtitle
        weakClearCache.text = nil;
        
        // 刷新表格
        [weakVc.tableView reloadData];
        
        [MBProgressHUD hideHUD];
    };
    
    group.items = @[clearCache];
    
    //    SYLog(@"%lld", [@"/Users/apple/Desktop/音乐" fileSize]);
}

- (void)dealloc
{
    NSLog(@"SYGeneralSettingViewController---dealloc");
}
@end
