//
//  SystemSettingViewController.m
//  CarCare
//
//  Created by joe on 2017/3/16.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "SystemSettingViewController.h"
#define shuzhijianxi 12




@interface SystemSettingViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong) UISwitch *zhengdongSwitch;
@property (nonatomic,strong) UISegmentedControl *yaliSeg;
@property (nonatomic,strong) UISegmentedControl *wenduSeg;
@property (nonatomic,strong) UILabel *yalishangxianLable;
@property (nonatomic,strong) UILabel *yalixiaxianLable;
@property (nonatomic,strong) UILabel *wendushanxianLable;
@property (nonatomic,strong) UILabel *dianliangxiaxianLable;
@property (nonatomic,strong) UISlider *yalishangxianSlide;
@property (nonatomic,strong) UISlider *yalixiaxianSlide;
@property (nonatomic,strong) UISlider *wendushangxianSlide;
@property (nonatomic,strong) UISlider *dianliangxiaxianSlide;

@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.title = NSLocalizedString(@"IDS_SYSTEM_SETTING",@"系统设置");
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    [self setupSubView];
    
    
    
//    if (![CommonFunction hasSetSetting]) {
//        NSString *yalidanwei = @"Bar";
//        NSString *wendudanwei = @"°C";
//        CGFloat defaultYaliShang = 3.0;
//        CGFloat defaultYaliXia = 2.0;
//        CGFloat defaultWenduShang = 65;
//        CGFloat defaultDianliang = 20;
//        
//        [CommonFunction setisZhenDong:NO];
//        [CommonFunction setyalidanwei:yalidanwei];
//        [CommonFunction setwendudanwei:wendudanwei];
//        [CommonFunction setdefaultYaliShang:defaultYaliShang];
//        [CommonFunction setdefaultYaliXia:defaultYaliXia];
//        [CommonFunction setdefaultWenduShang:defaultWenduShang];
//        [CommonFunction setdefaultdianliangXia:defaultDianliang];
//        
//        
//        [CommonFunction setHasSetSetting];
//    }
    
    [self reloadData];

    
}


- (void)reloadData{
    if ([CommonFunction isZhenDong]) {
        self.zhengdongSwitch.on = YES;
    }else{
        self.zhengdongSwitch.on = NO;
    }
    
    
    NSString *yalidanwei = [CommonFunction yalidanwei];
    if ([yalidanwei isEqualToString:@"Bar"]) {
        
        self.yaliSeg.selectedSegmentIndex = 2;
        self.yalishangxianSlide.maximumValue = 6.4;
        self.yalishangxianSlide.minimumValue = 2.8;
        self.yalixiaxianSlide.maximumValue = 2.5;
        self.yalixiaxianSlide.minimumValue = 1.0;
        
        
    }else if ([yalidanwei isEqualToString:@"Kpa"]){
        
        self.yaliSeg.selectedSegmentIndex = 1;
        self.yalishangxianSlide.maximumValue = 640;
        self.yalishangxianSlide.minimumValue = 280;
        self.yalixiaxianSlide.maximumValue = 250;
        self.yalixiaxianSlide.minimumValue = 100;

    }else{
        self.yaliSeg.selectedSegmentIndex = 0;
        self.yalishangxianSlide.maximumValue = 92.8;
        self.yalishangxianSlide.minimumValue = 40.6;
        self.yalixiaxianSlide.maximumValue = 36.2;
        self.yalixiaxianSlide.minimumValue = 14.5;
    }
    
    self.yalishangxianLable.text = [NSString stringWithFormat:@"%.1f",[CommonFunction defaultYaliShang]];
    self.yalishangxianSlide.value = [CommonFunction defaultYaliShang];
    self.yalixiaxianLable.text = [NSString stringWithFormat:@"%.1f",[CommonFunction defaultYaliXia]];
    self.yalixiaxianSlide.value = [CommonFunction defaultYaliXia];

    
    
    NSString * wendudanwei = [CommonFunction wendudanwei];
    if ([wendudanwei isEqualToString:@"°C"]) {
        self.wenduSeg.selectedSegmentIndex = 0;
        self.wendushangxianSlide.maximumValue = 80;
        self.wendushangxianSlide.minimumValue = 60;
    }else{
        self.wenduSeg.selectedSegmentIndex = 1;
        self.wendushangxianSlide.maximumValue = 176;
        self.wendushangxianSlide.minimumValue = 140;
    }
    
    self.wendushanxianLable.text = [NSString stringWithFormat:@"%.1f",[CommonFunction defaultWenduShang]];
    self.wendushangxianSlide.value = [CommonFunction defaultWenduShang];

    
    self.dianliangxiaxianLable.text = [NSString stringWithFormat:@"%.0f%%",[CommonFunction defaultdianliangXia]];
    self.dianliangxiaxianSlide.maximumValue = 100;
    self.dianliangxiaxianSlide.minimumValue = 0;
    self.dianliangxiaxianSlide.value = [CommonFunction defaultdianliangXia];

}


- (void)setupSubView{
    UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollerView];
//    scrollerView.contentSize = CGSizeMake(WindowWidth, WindowHeight);
    
    UIView *view1 = [[UIView alloc]init];
    view1.layer.borderColor = mainColor.CGColor;
    view1.layer.borderWidth = 1;
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 10;
    [scrollerView addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(64 + shuzhijianxi);
        make.height.equalTo(@44);
    }];
    
    
    
    UILabel *labe1 = [[UILabel alloc]init];
    labe1.text =NSLocalizedString(@"IDS_SHOCK_ALERT",@"震动报警") ;
    labe1.textColor = [UIColor whiteColor];
    [view1 addSubview:labe1];
    [labe1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_left).offset(12);
        make.top.equalTo(view1.mas_top);
        make.bottom.equalTo(view1.mas_bottom);
    }];
    
    
    self.zhengdongSwitch = [[UISwitch alloc]init];
    [scrollerView addSubview:self.zhengdongSwitch];
    [self.zhengdongSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view1.mas_right).offset(-12);
        make.centerY.equalTo(view1.mas_centerY);
    }];
    [self.zhengdongSwitch addTarget:self action:@selector(zhendongClicked:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    
    
    UIView *view2 = [[UIView alloc]init];
    view2.layer.borderColor = mainColor.CGColor;
    view2.layer.borderWidth = 1;
    view2.layer.masksToBounds = YES;
    view2.layer.cornerRadius = 10;
    [scrollerView addSubview:view2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(view1.mas_bottom).offset(shuzhijianxi);
        make.height.equalTo(@88);
    }];
    
    UILabel *labe2_1 = [[UILabel alloc]init];
    labe2_1.text =NSLocalizedString(@"IDS_PRESSURE_UNIT",@"压力单位") ;
    labe2_1.textColor = [UIColor whiteColor];
    [view2 addSubview:labe2_1];
    [labe2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2.mas_left).offset(12);
        make.top.equalTo(view2.mas_top);
        make.height.equalTo(@44);
    }];
    
    UILabel *labe2_2 = [[UILabel alloc]init];
    labe2_2.text = NSLocalizedString(@"IDS_TEMPERATURE_UNIT",@"温度单位") ;
    labe2_2.textColor = [UIColor whiteColor];
    [view2 addSubview:labe2_2];
    [labe2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2.mas_left).offset(12);
        make.top.equalTo(labe2_1.mas_bottom);
        make.height.equalTo(@44);
    }];
    
    
    UIView *line2_1 = [[UIView alloc]init];
    line2_1.backgroundColor = mainColor;
    [view2 addSubview:line2_1];
    [line2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2.mas_left);
        make.right.equalTo(view2.mas_right);
        make.top.equalTo(labe2_1.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    
    UISegmentedControl *yaliSegment = [[UISegmentedControl alloc]initWithItems:@[@"Psi",@"Kpa",@"Bar"]];
    [view2 addSubview:yaliSegment];
    [yaliSegment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view2.mas_right).offset(-12);
        make.centerY.equalTo(labe2_1.mas_centerY);
    }];
    self.yaliSeg= yaliSegment;
    [self.yaliSeg addTarget:self action:@selector(yaliSegClicked:) forControlEvents:UIControlEventValueChanged];
    
    
    UISegmentedControl *wenduSegment = [[UISegmentedControl alloc]initWithItems:@[@"°C",@"°F"]];
    [view2 addSubview:wenduSegment];
    [wenduSegment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view2.mas_right).offset(-12);
        make.centerY.equalTo(labe2_2.mas_centerY);
    }];
    self.wenduSeg = wenduSegment;
    [self.wenduSeg addTarget:self action:@selector(wenduSegClcicked:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    UIView *view3 = [[UIView alloc]init];
    view3.layer.borderColor = mainColor.CGColor;
    view3.layer.borderWidth = 1;
    view3.layer.masksToBounds = YES;
    view3.layer.cornerRadius = 10;
    [scrollerView addSubview:view3];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(view2.mas_bottom).offset(shuzhijianxi);
        make.height.equalTo(@240);
    }];
    
    
    UIView *line3_1 = [[UIView alloc]init];
    line3_1.backgroundColor = mainColor;
    [view3 addSubview:line3_1];
    [line3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left);
        make.right.equalTo(view3.mas_right);
        make.top.equalTo(view3.mas_top).offset(60);
        make.height.equalTo(@1);
    }];
    
    UIView *line3_2 = [[UIView alloc]init];
    line3_2.backgroundColor = mainColor;
    [view3 addSubview:line3_2];
    [line3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left);
        make.right.equalTo(view3.mas_right);
        make.top.equalTo(view3.mas_top).offset(120);
        make.height.equalTo(@1);
    }];
    
    UIView *line3_3 = [[UIView alloc]init];
    line3_3.backgroundColor = mainColor;
    [view3 addSubview:line3_3];
    [line3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left);
        make.right.equalTo(view3.mas_right);
        make.top.equalTo(view3.mas_top).offset(180);
        make.height.equalTo(@1);
    }];
    
    
    
    UILabel *lable3_1 = [[UILabel alloc]init];
    lable3_1.text =NSLocalizedString(@"IDS_PRESSURE_ALERT_UPPER",@"压力警告上限") ;
    lable3_1.textColor = [UIColor whiteColor];
    [view3 addSubview:lable3_1];
    [lable3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left).offset(12);
        make.top.equalTo(view3.mas_top).offset(5);
    }];
    
    UISlider *slide3_1 = [[UISlider alloc]init];
    slide3_1.value = 0.5;
    [view3 addSubview:slide3_1];
    [slide3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left).offset(30);
        make.right.equalTo(view3.mas_right).offset(-30);
        make.top.equalTo(lable3_1.mas_bottom);
    }];
    self.yalishangxianSlide = slide3_1;
    [self.yalishangxianSlide addTarget:self action:@selector(yalishangxianSlide_cilcked:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *yalishangxianLable = [[UILabel alloc]init];
    yalishangxianLable.textColor = mainColor;
    yalishangxianLable.text = @"30";
    [view3 addSubview:yalishangxianLable];
    [yalishangxianLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lable3_1.mas_centerY);
        make.right.equalTo(view3.mas_right).offset(-12);
    }];
    self.yalishangxianLable =yalishangxianLable;
    
    
    UILabel *lable3_2 = [[UILabel alloc]init];
    lable3_2.text =NSLocalizedString(@"IDS_PRESSURE_ALERT_DOWN",@"压力警告下限")  ;
    lable3_2.textColor = [UIColor whiteColor];
    [view3 addSubview:lable3_2];
    [lable3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left).offset(12);
        make.top.equalTo(line3_1.mas_top).offset(5);
    }];
    
    UISlider *slide3_2 = [[UISlider alloc]init];
    slide3_2.value = 0.5;
    [view3 addSubview:slide3_2];
    [slide3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left).offset(30);
        make.right.equalTo(view3.mas_right).offset(-30);
        make.top.equalTo(lable3_2.mas_bottom);
    }];
    self.yalixiaxianSlide = slide3_2;
    [self.yalixiaxianSlide addTarget:self action:@selector(yalixiaxianSlide_cilcked:) forControlEvents:UIControlEventValueChanged];

    
    UILabel *yalixiaxianLable = [[UILabel alloc]init];
    yalixiaxianLable.textColor = mainColor;
    yalixiaxianLable.text = @"30";
    [view3 addSubview:yalixiaxianLable];
    [yalixiaxianLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lable3_2.mas_centerY);
        make.right.equalTo(view3.mas_right).offset(-12);
    }];
    self.yalixiaxianLable = yalixiaxianLable;
    
    UILabel *lable3_3 = [[UILabel alloc]init];
    lable3_3.text =NSLocalizedString(@"IDS_TEMPERATURE_ALERT_UPPER",@"温度警告上限") ;
    lable3_3.textColor = [UIColor whiteColor];
    [view3 addSubview:lable3_3];
    [lable3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left).offset(12);
        make.top.equalTo(line3_2.mas_top).offset(5);
    }];
    
    UISlider *slide3_3 = [[UISlider alloc]init];
    slide3_3.value = 0.5;
    [view3 addSubview:slide3_3];
    [slide3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left).offset(30);
        make.right.equalTo(view3.mas_right).offset(-30);
        make.top.equalTo(lable3_3.mas_bottom);
    }];
    self.wendushangxianSlide = slide3_3;
    [self.wendushangxianSlide addTarget:self action:@selector(wendushangxianSlide_cilcked:) forControlEvents:UIControlEventValueChanged];

    
    UILabel *wendushangxianLable = [[UILabel alloc]init];
    wendushangxianLable.textColor = mainColor;
    wendushangxianLable.text = @"30";
    [view3 addSubview:wendushangxianLable];
    [wendushangxianLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lable3_3.mas_centerY);
        make.right.equalTo(view3.mas_right).offset(-12);
    }];
    self.wendushanxianLable = wendushangxianLable;
    
    UILabel *lable3_4 = [[UILabel alloc]init];
    lable3_4.text = NSLocalizedString(@"IDS_BATTERY_ALERT_DOWN",@"电量警报下限");
    lable3_4.textColor = [UIColor whiteColor];
    [view3 addSubview:lable3_4];
    [lable3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left).offset(12);
        make.top.equalTo(line3_3.mas_top).offset(5);
    }];
    
    UISlider *slide3_4 = [[UISlider alloc]init];
    slide3_4.value = 0.5;
    [view3 addSubview:slide3_4];
    [slide3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3.mas_left).offset(30);
        make.right.equalTo(view3.mas_right).offset(-30);
        make.top.equalTo(lable3_4.mas_bottom);
    }];
    self.dianliangxiaxianSlide = slide3_4;
    [self.dianliangxiaxianSlide addTarget:self action:@selector(dianliangxiaxianSlide_cilcked:) forControlEvents:UIControlEventValueChanged];

    
    UILabel *dianliangxiaxianLable = [[UILabel alloc]init];
    dianliangxiaxianLable.textColor = mainColor;
    dianliangxiaxianLable.text = @"30";
    [view3 addSubview:dianliangxiaxianLable];
    [dianliangxiaxianLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lable3_4.mas_centerY);
        make.right.equalTo(view3.mas_right).offset(-12);
    }];
    self.dianliangxiaxianLable = dianliangxiaxianLable;
    
    
    UIView *view4 = [[UIView alloc]init];
    view4.layer.borderColor = mainColor.CGColor;
    view4.layer.borderWidth = 1;
    view4.layer.masksToBounds = YES;
    view4.layer.cornerRadius = 10;
    [scrollerView addSubview:view4];
    
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(view3.mas_bottom).offset(shuzhijianxi);
        make.height.equalTo(@44);
    }];
    
    
    UIButton *btn4_1 = [[UIButton alloc]init];
    [btn4_1 setTitle:NSLocalizedString(@"IDS_BACK_TO_DEFAULR_SETTING",@"恢复默认设置") forState:UIControlStateNormal];
    [btn4_1 setTitleColor:mainColor forState:UIControlStateNormal];
    [view4 addSubview:btn4_1];
    [btn4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4.mas_left);
        make.right.equalTo(view4.mas_right);
        make.centerY.equalTo(view4.mas_centerY);
    }];
    
    [btn4_1 addTarget:self action:@selector(btn4_1_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    

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

#pragma mark sender
- (void)zhendongClicked:(UISwitch *)zhendongSwitch{
    
    [CommonFunction setisZhenDong:zhendongSwitch.isOn];
    [self reloadData];
    
}

- (void)yaliSegClicked:(UISegmentedControl *)segment{
    
    switch (segment.selectedSegmentIndex) {
        case 0:{
            if ([[CommonFunction yalidanwei] isEqualToString:@"Kpa"])  {
                [CommonFunction setdefaultYaliXia:[CommonFunction defaultYaliXia] / PsiToKpa];
                [CommonFunction setdefaultYaliShang:[CommonFunction defaultYaliShang] / PsiToKpa];

            }else if([[CommonFunction yalidanwei] isEqualToString:@"Bar"]){
                [CommonFunction setdefaultYaliXia:[CommonFunction defaultYaliXia] * BarToPsi];
                [CommonFunction setdefaultYaliShang:[CommonFunction defaultYaliShang] * BarToPsi];
            }
            [CommonFunction setyalidanwei:@"Psi"];
            
        }
            break;
        case 1:
            
            if ([[CommonFunction yalidanwei] isEqualToString:@"Psi"])  {
                [CommonFunction setdefaultYaliXia:[CommonFunction defaultYaliXia] * PsiToKpa];
                [CommonFunction setdefaultYaliShang:[CommonFunction defaultYaliShang] * PsiToKpa];

            }else if([[CommonFunction yalidanwei] isEqualToString:@"Bar"]){
                [CommonFunction setdefaultYaliXia:[CommonFunction defaultYaliXia] * 100];
                [CommonFunction setdefaultYaliShang:[CommonFunction defaultYaliShang] * 100];

            }

            
            
            [CommonFunction setyalidanwei:@"Kpa"];

            break;
        case 2:
            
            if ([[CommonFunction yalidanwei] isEqualToString:@"Psi"])  {
                [CommonFunction setdefaultYaliXia:[CommonFunction defaultYaliXia] / BarToPsi];
                [CommonFunction setdefaultYaliShang:[CommonFunction defaultYaliShang] / BarToPsi];

            }else if([[CommonFunction yalidanwei] isEqualToString:@"Kpa"]){
                [CommonFunction setdefaultYaliXia:[CommonFunction defaultYaliXia] * 0.01];
                [CommonFunction setdefaultYaliShang:[CommonFunction defaultYaliShang] * 0.01];

            }
            [CommonFunction setyalidanwei:@"Bar"];

            break;
            
        default:
            break;
    }
    
    
    [self reloadData];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UnitChangeNoti" object:nil];

    
    
}
//"°C",@"°F"
- (void)wenduSegClcicked:(UISegmentedControl *)segmeng{
    
    
    switch (segmeng.selectedSegmentIndex) {
        case 0:{
            
            [CommonFunction setdefaultWenduShang:([CommonFunction defaultWenduShang] -32) / 1.8];
            [CommonFunction setwendudanwei:@"°C"];
            
        }
            break;
        case 1:
            
            [CommonFunction setdefaultWenduShang:[CommonFunction defaultWenduShang] * 1.8 + 32];
            [CommonFunction setwendudanwei:@"°F"];
            
            break;
        default:
            break;
    }
    
    
    [self reloadData];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"UnitChangeNoti" object:nil];
    
}

- (void)yalishangxianSlide_cilcked:(UISlider *)slide{
    
    [CommonFunction setdefaultYaliShang:slide.value];
    [self reloadData];

    
}

- (void)yalixiaxianSlide_cilcked:(UISlider *)slide{
    [CommonFunction setdefaultYaliXia:slide.value];
    [self reloadData];

}

- (void)wendushangxianSlide_cilcked:(UISlider *)slide{
    [CommonFunction setdefaultWenduShang:slide.value];
    [self reloadData];

}

- (void)dianliangxiaxianSlide_cilcked:(UISlider *)slide{
    [CommonFunction setdefaultdianliangXia:slide.value];
    [self reloadData];

}

- (void)btn4_1_clicked{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@?",NSLocalizedString(@"IDS_BACK_TO_DEFAULR_SETTING",@"恢复默认设置")] delegate:self cancelButtonTitle:NSLocalizedString(@"IDS_CANCEL",@"取消") otherButtonTitles:NSLocalizedString(@"IDS_ENSURE",@"确定"), nil];
    [alert show];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSString *yalidanwei = @"Bar";
        NSString *wendudanwei = @"°C";
        CGFloat defaultYaliShang = 3.0;
        CGFloat defaultYaliXia = 2.0;
        CGFloat defaultWenduShang = 65;
        CGFloat defaultDianliang = 20;
        
        [CommonFunction setisZhenDong:NO];
        [CommonFunction setyalidanwei:yalidanwei];
        [CommonFunction setwendudanwei:wendudanwei];
        [CommonFunction setdefaultYaliShang:defaultYaliShang];
        [CommonFunction setdefaultYaliXia:defaultYaliXia];
        [CommonFunction setdefaultWenduShang:defaultWenduShang];
        [CommonFunction setdefaultdianliangXia:defaultDianliang];
    }
    
    [self reloadData];
}


@end
