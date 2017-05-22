//
//  HelpViewController.m
//  CarCare
//
//  Created by joe on 2017/3/23.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "SystemInstallDesController.h"

@interface SystemInstallDesController ()

@end

@implementation SystemInstallDesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.title = NSLocalizedString(@"IDS_DEVICE_INSTALL_DES",@"设备安装说明");
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIScrollView *scroller = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scroller];
    
    UIImage * bcImage;
    if ([[[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode] isEqualToString:@"zh"]) {
        bcImage = [UIImage imageNamed:@"帮助 — 设备安装说明"];
    }else{
        bcImage = [UIImage imageNamed:@"帮助 — 设备安装说明EN"];
    }
    
    
    CGSize size = bcImage.size;
    
    scroller.contentSize = CGSizeMake(WindowWidth, size.width / WindowWidth * size.height);
    
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, size.width / WindowWidth * size.height)];
    imgView.image = bcImage;
    [scroller addSubview:imgView];
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
