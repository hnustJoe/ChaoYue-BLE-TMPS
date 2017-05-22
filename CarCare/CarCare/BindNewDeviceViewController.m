//
//  BindNewDeviceViewController.m
//  CarCare
//
//  Created by joe on 2017/3/12.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "BindNewDeviceViewController.h"
#import "MainBindViewController.h"
#import "AutoBindViewController.h"


@interface BindNewDeviceViewController ()
@property (weak, nonatomic) IBOutlet UIButton *manulBindBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoBindbtn;

@end

@implementation BindNewDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.title = NSLocalizedString(@"IDS_BIND_NEW_DEVICE", @"绑定新设备");
    
    [self.manulBindBtn setTitleColor:mainColor forState:UIControlStateNormal];
    [self.autoBindbtn setTitleColor:mainColor forState:UIControlStateNormal];
    

    [self.manulBindBtn setTitle:NSLocalizedString(@"IDS_MAUNAL_BIND", "手动绑定") forState:UIControlStateNormal];
    [self.autoBindbtn setTitle:NSLocalizedString(@"IDS_AUTO_BIND", "自动配对") forState:UIControlStateNormal];


    [_manulBindBtn.layer setMasksToBounds:YES];
    [_manulBindBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [_manulBindBtn.layer setBorderWidth:1.0];
    _manulBindBtn.layer.borderColor = mainColor.CGColor;

    
    [_autoBindbtn.layer setMasksToBounds:YES];
    [_autoBindbtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [_autoBindbtn.layer setBorderWidth:1.0];
    _autoBindbtn.layer.borderColor = mainColor.CGColor;
    
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
- (IBAction)manulBind_clicked:(id)sender {
    MainBindViewController *vc = [[MainBindViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (IBAction)aotuBind_clicked:(id)sender {
    
    AutoBindViewController *vc = [[AutoBindViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
