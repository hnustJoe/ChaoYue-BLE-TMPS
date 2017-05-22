//
//  APPUseDesViewController.m
//  CarCare
//
//  Created by joe on 2017/5/8.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "APPUseDesViewController.h"

@interface APPUseDesViewController ()

@end

@implementation APPUseDesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.title = NSLocalizedString(@"IDS_APP_USE_DES",@"APP使用说明");
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIScrollView *scroller = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scroller];
    
    
    UIImage * bcImage;
    if ([[[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode] isEqualToString:@"zh"]) {
        bcImage = [UIImage imageNamed:@"帮助 — APP使用说明"];
    }else{
        bcImage = [UIImage imageNamed:@"帮助 — APP使用说明EN"];
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


@end
