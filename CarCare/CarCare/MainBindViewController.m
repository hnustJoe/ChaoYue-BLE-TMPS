//
//  MainBindViewController.m
//  CarCare
//
//  Created by joe on 2017/3/23.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "MainBindViewController.h"
#import "BindDeviceView.h"


@interface MainBindViewController ()<BindDeviceViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *bind1Btn;
@property (weak, nonatomic) IBOutlet UIButton *bind2Btn;
@property (weak, nonatomic) IBOutlet UIButton *bind3Btn;
@property (weak, nonatomic) IBOutlet UIButton *bind4Btn;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img3;

@end

@implementation MainBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.title = NSLocalizedString(@"IDS_MANUAL_BIND_NEW_DEVICE", @"手动绑定新设备");
    
    
//    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.image = [UIImage imageNamed:@"组-8"];
//    [self.view addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.top.equalTo(self.img1.mas_bottom);
//        make.bottom.equalTo(self.img3.mas_top);
//    }];
//    
    
    [self reloadData];
    
    
}

- (void)reloadData{
    if (![CommonFunc wheal1MacString]) {
        [self.bind1Btn setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE",@"请绑定设备") forState:UIControlStateNormal];
        [self.bind1Btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.bind1Btn setTitle:[[CommonFunc wheal1MacString] substringFromIndex:6] forState:UIControlStateNormal];
        [self.bind1Btn setTitleColor:mainColor forState:UIControlStateNormal];
        
    }
    
    if (![CommonFunc wheal2MacString]) {
        [self.bind2Btn setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE",@"请绑定设备") forState:UIControlStateNormal];
        [self.bind2Btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.bind2Btn setTitle:[[CommonFunc wheal2MacString] substringFromIndex:6] forState:UIControlStateNormal];
        [self.bind2Btn setTitleColor:mainColor forState:UIControlStateNormal];
        
        
    }
    
    if (![CommonFunc wheal3MacString]) {
        [self.bind3Btn setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE",@"请绑定设备") forState:UIControlStateNormal];
        [self.bind3Btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.bind3Btn setTitle:[[CommonFunc wheal3MacString] substringFromIndex:6] forState:UIControlStateNormal];
        [self.bind3Btn setTitleColor:mainColor forState:UIControlStateNormal];
        
        
    }
    
    if (![CommonFunc wheal4MacString]) {
        [self.bind4Btn setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE",@"请绑定设备") forState:UIControlStateNormal];
        [self.bind4Btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [self.bind4Btn setTitle:[[CommonFunc wheal4MacString] substringFromIndex:6] forState:UIControlStateNormal];
        [self.bind1Btn setTitleColor:mainColor forState:UIControlStateNormal];
        
        
    }
}

- (IBAction)bindclicked:(UIButton *)sender {
    BindDeviceView *bindView = [[BindDeviceView alloc]init];
    bindView.tag = sender.tag;
    bindView.delegate = self;
    [self.view addSubview:bindView];
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

#pragma mark BindDeviceViewDelegate
- (void)certainClickView:(BindDeviceView *)view text:(NSString *)text{
    
    
    switch (view.tag) {
        case 1:
            [CommonFunc setWheahlmacstring:[NSString stringWithFormat:@"800000%@",text]];

            break;
        case 2:
            [CommonFunc setWheah2macstring:[NSString stringWithFormat:@"810000%@",text]];

            break;
        case 3:
            [CommonFunc setWheah3macstring:[NSString stringWithFormat:@"820000%@",text]];

            break;
        case 4:
            [CommonFunc setWheah4macstring:[NSString stringWithFormat:@"830000%@",text]];
            break;
        default:
            break;
    }
    
    [self reloadData];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"bindNewDevice" object:nil];
    
}

@end
