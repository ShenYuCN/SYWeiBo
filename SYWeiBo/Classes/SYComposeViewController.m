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
#import "SYComposePhotosView.h"
#import "SYEmotionKeyBoard.h"
@interface SYComposeViewController ()<UITextViewDelegate,SYComposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) SYTextView *textView;
@property (nonatomic,weak) SYComposeToolbar *toolbar;
@property (nonatomic,weak) SYComposePhotosView *photosView;
@property (nonatomic,assign) BOOL beginSwitchKeyBoard;
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

    //添加相册
    [self setupPhotosView];
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
    if (self.textView.hasText) return;
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
    [self.textView becomeFirstResponder];
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
/**
 *  设置工具条
 */
-(void)setupToolbar{
    SYComposeToolbar *toolbar = [[SYComposeToolbar alloc] init];
    toolbar.height = 44;
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    //inputAccessoryView设置显示在键盘顶部的内容,inputView显示键盘
    //如果没有要求，退出键盘后toolbar也隐藏，则这局代码完全可以实现
    //self.textView.inputAccessoryView = toolbar;
    
    toolbar.delegate = self;
    self.toolbar = toolbar;
    [self.view addSubview:toolbar];
}
-(void)setupPhotosView{
    SYComposePhotosView *photosView = [[SYComposePhotosView alloc] init];
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    photosView.y = 100;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}
#pragma mark - SYComposeToolBarDelegate
/**
 *  工具条点击事件的监听
 */
-(void)compostToolBar:(SYComposeToolbar *)toolbar didClickButton:(SYComposeToolbarButtonType)buttonType{

    switch (buttonType) {
        case SYComposeToolbarButtonTypeCamera: // 拍照
            NSLog(@"拍照");
            [self openCamera];
            break;
            
        case SYComposeToolbarButtonTypePicture: // 相册
            NSLog(@"---  相册");
            [self openAlbum];
            break;
            
        case SYComposeToolbarButtonTypeMention: // @
            NSLog(@"--- @");
            break;
            
        case SYComposeToolbarButtonTypeTrend: // #
            NSLog(@"--- #");
            break;
            
        case SYComposeToolbarButtonTypeEmotion: // 表情\键盘
            NSLog(@"--- 表情");
            [self switchKeyBoard];
            break;
    }
}
#pragma mark - toolBar Button选中的其他方法
/**
 *  打开相机
 */
-(void)openCamera{
   [self openImagePickViewController:UIImagePickerControllerSourceTypeCamera];
}
/**
 *  打开相册
 */
-(void)openAlbum{
    [self openImagePickViewController:UIImagePickerControllerSourceTypePhotoLibrary];
}
/**
 *  打开相机和相册的封装
 */
-(void)openImagePickViewController:(UIImagePickerControllerSourceType)sourceType{
    if (![UIImagePickerController isSourceTypeAvailable:sourceType ] ) return;    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = sourceType;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
/**
 *  切换键盘
 */
-(void)switchKeyBoard{
    
    self.beginSwitchKeyBoard = YES;
    //这个键盘直接设置inputView后必须关掉键盘再打开键盘才能切换表情键盘
    SYEmotionKeyBoard *keyBoard = [[SYEmotionKeyBoard alloc] init];
    keyBoard.width = self.view.width;
    keyBoard.height = 216;
    self.textView.inputView = keyBoard;
    
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
        self.beginSwitchKeyBoard = NO;
    });
}
#pragma mark - UIImagePickerControllerDelegate 代理方法
/**
 *  UIImagePickerControllerDelegate,选中图片后的操作
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextView代理方法
/**
 *  拖动视图，隐藏键盘
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark - 监听方法
/**
 *  键盘frame改变时的监听
 */
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    
     // 如果正在切换键盘，就不要执行后面的代码.这样tabBar就不会随键盘上下移动了.
    if (self.beginSwitchKeyBoard) return;
    
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
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        //在ios 9.0,1只需要最后一句代码
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];

}
-(void)textDidChanged{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)send{
    
    if (self.photosView.photos.count) {
        //发送带图片的微博
        [self sendWithImage];
    }else{
        //发送没有图片的微博
        [self sendWithoutImage];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 发送微博，上传数据
/**
 *   发送带图片的微博
 */
-(void)sendWithImage{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = [SYAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImageView *imageView = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(imageView.image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"ete.jpg" mimeType:@"image/jpeg"];
    
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];

}
/**
 *  发送没有图片的微博
 */
-(void)sendWithoutImage{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SYAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

@end
