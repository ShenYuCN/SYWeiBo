//
//  SYStatusDetailViewController.m
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import "SYStatusDetailViewController.h"
// RGB颜色
#define SYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface SYStatusDetailViewController ()

@end

@implementation SYStatusDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = SYColor(211, 211, 211);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

@end
