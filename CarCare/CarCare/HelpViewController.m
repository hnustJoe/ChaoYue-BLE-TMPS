//
//  HelpViewController.m
//  CarCare
//
//  Created by joe on 2017/5/8.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "HelpViewController.h"
#import "SystemInstallDesController.h"
#import "APPUseDesViewController.h"


@interface HelpViewController ()
@property (weak, nonatomic) IBOutlet UIButton *InstallDesBtn;
@property (weak, nonatomic) IBOutlet UIButton *APPUseDes;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.title = NSLocalizedString(@"IDS_HELP", @"帮助");
    
    [self.InstallDesBtn setTitleColor:mainColor forState:UIControlStateNormal];
    [self.APPUseDes setTitleColor:mainColor forState:UIControlStateNormal];
    
    

    [self.InstallDesBtn setTitle:NSLocalizedString(@"IDS_DEVICE_INSTALL_DES", @"设备安装说明") forState:UIControlStateNormal];
    
    [self.APPUseDes setTitle:NSLocalizedString(@"IDS_APP_USE_DES", @"APP使用说明") forState:UIControlStateNormal];

    
    
    
    [_InstallDesBtn.layer setMasksToBounds:YES];
    [_InstallDesBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [_InstallDesBtn.layer setBorderWidth:1.0];
    _InstallDesBtn.layer.borderColor = mainColor.CGColor;
    
    
    [_APPUseDes.layer setMasksToBounds:YES];
    [_APPUseDes.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [_APPUseDes.layer setBorderWidth:1.0];
    _APPUseDes.layer.borderColor = mainColor.CGColor;
    
    self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)InstallDesClciked:(id)sender {
    
    SystemInstallDesController *vc = [[SystemInstallDesController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)APPUseDes:(id)sender {
    
    APPUseDesViewController *vc = [[APPUseDesViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
