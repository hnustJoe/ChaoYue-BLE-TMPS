//
//  AutoBindViewController.m
//  CarCare
//
//  Created by joe on 2017/3/23.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "AutoBindViewController.h"
#import "AotuSearchView.h"

@interface AutoBindViewController ()
@property (weak, nonatomic) IBOutlet UIButton *bind1Btn;
@property (weak, nonatomic) IBOutlet UIButton *bind2Btn;
@property (weak, nonatomic) IBOutlet UIButton *bind3Btn;
@property (weak, nonatomic) IBOutlet UIButton *bind4Btn;

@end

@implementation AutoBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.title = NSLocalizedString(@"IDS_AUTO_BIND_NEW_DEVICE",@"自动绑定新设备");

    [self reloadData];

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"findNewDevice" object:nil];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}



- (void)reloadData{
    if (![CommonFunction wheal1MacString]) {
        [self.bind1Btn setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE",@"请绑定设备")forState:UIControlStateNormal];
        [self.bind1Btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.bind1Btn setTitle:[[CommonFunction wheal1MacString] substringFromIndex:6] forState:UIControlStateNormal];
        [self.bind1Btn setTitleColor:mainColor forState:UIControlStateNormal];
        
    }
    
    if (![CommonFunction wheal2MacString]) {
        [self.bind2Btn setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE",@"请绑定设备") forState:UIControlStateNormal];
        [self.bind2Btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.bind2Btn setTitle:[[CommonFunction wheal2MacString] substringFromIndex:6] forState:UIControlStateNormal];
        [self.bind2Btn setTitleColor:mainColor forState:UIControlStateNormal];
        
        
    }
    
    if (![CommonFunction wheal3MacString]) {
        [self.bind3Btn setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE",@"请绑定设备") forState:UIControlStateNormal];
        [self.bind3Btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.bind3Btn setTitle:[[CommonFunction wheal3MacString] substringFromIndex:6] forState:UIControlStateNormal];
        [self.bind3Btn setTitleColor:mainColor forState:UIControlStateNormal];
        
        
    }
    
    if (![CommonFunction wheal4MacString]) {
        [self.bind4Btn setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE",@"请绑定设备") forState:UIControlStateNormal];
        [self.bind4Btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.bind4Btn setTitle:[[CommonFunction wheal4MacString] substringFromIndex:6] forState:UIControlStateNormal];
        [self.bind1Btn setTitleColor:mainColor forState:UIControlStateNormal];
        
        
    }
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)bind1_clicked:(id)sender {
    AotuSearchView * view = [[AotuSearchView alloc]initWithindex:1];
    [view show];
    
}
- (IBAction)bind2_Clicked:(id)sender {
    AotuSearchView * view = [[AotuSearchView alloc]initWithindex:2];
    [view show];
}
- (IBAction)bind3_clicked:(id)sender {
    AotuSearchView * view = [[AotuSearchView alloc]initWithindex:3];
    [view show];
}
- (IBAction)bind4_clicked:(id)sender {
    AotuSearchView * view = [[AotuSearchView alloc]initWithindex:4];
    [view show];
}





- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
