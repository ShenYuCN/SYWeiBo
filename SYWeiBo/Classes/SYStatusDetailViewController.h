//
//  SYStatusDetailViewController.h
//  SYWeiBo
//
//  Created by Shen Yu on 15/11/18.
//  Copyright © 2015年 Shen Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYStatus,SYStatusFrame;
@interface SYStatusDetailViewController : UIViewController

@property (nonatomic,strong) SYStatus   *status;
@property (nonatomic,strong) SYStatusFrame *statusFrame;
@end
