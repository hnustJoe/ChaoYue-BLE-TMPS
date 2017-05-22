//
//  ViewController.m
//  CarCare
//
//  Created by joe on 2017/3/8.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "ViewController.h"

#import "MIBadgeButton.h"
#import <CoreBluetooth/CoreBluetooth.h>
#include <stdio.h>
#import "BindDeviceView.h"
#import <AVFoundation/AVFoundation.h>
#import "BindNewDeviceViewController.h"
#import "SystemSettingViewController.h"
#import "HelpViewController.h"

//#import "UIImage+GIF.h"
#import "AnimatedGIFImageSerialization.h"



#define TopViewRightWidth 62


#define yaliluoji 0.75

@interface ViewController ()<CBCentralManagerDelegate,BindDeviceViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,AVAudioPlayerDelegate>
@property (nonatomic,strong) MIBadgeButton *showLeftBtn;
@property (nonatomic,strong) UILabel *mainTitleLable;
@property (nonatomic,strong) UIButton *trackBtn;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,strong) UIButton *bleStateBtn;


@property (nonatomic,strong) UIImageView *leftUpImageView;
@property (nonatomic,strong) UIImageView *rightUpImageView;
@property (nonatomic,strong) UIImageView *leftDownImageView;
@property (nonatomic,strong) UIImageView *rightDownImageView;


//未绑定的按钮
@property (nonatomic,strong) UIButton *unBinDBtn1;
@property (nonatomic,strong) UIButton *unBinDBtn2;
@property (nonatomic,strong) UIButton *unBinDBtn3;
@property (nonatomic,strong) UIButton *unBinDBtn4;


@property (nonatomic,strong) UILabel *wendu1;
@property (nonatomic,strong) UILabel *wendu2;
@property (nonatomic,strong) UILabel *wendu3;
@property (nonatomic,strong) UILabel *wendu4;


@property (nonatomic,strong) UILabel *taiya1;
@property (nonatomic,strong) UILabel *taiya2;
@property (nonatomic,strong) UILabel *taiya3;
@property (nonatomic,strong) UILabel *taiya4;


@property (nonatomic,strong) UILabel *luoqiAlertLable1;
@property (nonatomic,strong) UILabel *luoqiAlertLable2;
@property (nonatomic,strong) UILabel *luoqiAlertLable3;
@property (nonatomic,strong) UILabel *luoqiAlertLable4;





@property (nonatomic,strong) UILabel *qiyaAlertLable1;
@property (nonatomic,strong) UILabel *dinaliangAlertLable1;
@property (nonatomic,strong) UILabel *wenduAlertLable1;


@property (nonatomic,strong) UILabel *qiyaAlertLable2;
@property (nonatomic,strong) UILabel *dinaliangAlertLable2;
@property (nonatomic,strong) UILabel *wenduAlertLable2;

@property (nonatomic,strong) UILabel *qiyaAlertLable3;
@property (nonatomic,strong) UILabel *dinaliangAlertLable3;
@property (nonatomic,strong) UILabel *wenduAlertLable3;

@property (nonatomic,strong) UILabel *qiyaAlertLable4;
@property (nonatomic,strong) UILabel *dinaliangAlertLable4;
@property (nonatomic,strong) UILabel *wenduAlertLable4;

@property (nonatomic,strong) UIAlertView *bleAlertView;



@property (nonatomic,strong) CBCentralManager *centralmanager;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;





@property (nonatomic,strong) NSMutableArray *voiceArr;
@property (nonatomic,strong) NSTimer *timer;


@property (nonatomic,strong) NSString *lastadvertisementData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addtop];
    
    
    self.centralmanager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.voiceArr = [NSMutableArray array];
    self.lastadvertisementData = [NSString string];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appEnterForeground) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UnitChangeNoti) name:@"UnitChangeNoti" object:nil];
    
    

    
}




- (void)playVoice{
    
//    NSLog(@"timer播放前%@",self.voiceArr);

    
    if (self.voiceArr.count > 0) {
        
        
        for (int i = 0; i < self.voiceArr.count; i++) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.voiceArr.count >= i + 1) {
                    NSString *voiceName = self.voiceArr[i];
                    [self playVoiceWithFileName:voiceName];
                }
                
                

            });
        }
        
       

        
    }
    
    
    
    
}


- (void)appEnterForeground{
    self.centralmanager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    
    [self performSelector:@selector(whealTimer1) withObject:nil afterDelay:60 * 10];
    [self performSelector:@selector(whealTimer2) withObject:nil afterDelay:60 * 10];
    [self performSelector:@selector(whealTimer3) withObject:nil afterDelay:60 * 10];
    [self performSelector:@selector(whealTimer4) withObject:nil afterDelay:60 * 10];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateView];
    
}

//测试播放声音
- (void)playVoiceWithFileName:(NSString *)fileName{
    
    if (![CommonFunction isPlayVioce]) {
        return;
    }

    
    if ([CommonFunction isZhenDong]) {
        NSNumber *openshark =  [[NSUserDefaults standardUserDefaults]objectForKey:@"openshark"];
        if (!openshark || [openshark boolValue] == 1) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }
    
    
    

    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSLog(@"异常语音:%@",fileName);
    
    
    NSString *str;
    if ([[[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode] isEqualToString:@"zh"]) {
        str = [[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"];
    }else{
        fileName = [fileName stringByAppendingString:@"EN"];
        str = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
    }
    
    
    NSURL *fileURL = [NSURL fileURLWithPath:str];
    // 2.创建 AVAudioPlayer 对象
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
    // 4.设置循环播放
    self.audioPlayer.numberOfLoops = 0;
    self.audioPlayer.delegate = self;
    // 5.开始播放
    [self.audioPlayer play];
    
}



- (void)updateView{
    
    NSString *mac1 = [CommonFunction getWheahl1DataString];
    NSString *mac2 = [CommonFunction getWheahl2DataString];
    NSString *mac3 = [CommonFunction getWheahl3DataString];
    NSString *mac4 = [CommonFunction getWheahl4DataString];
    
    if (mac1.length == 0) {
        self.unBinDBtn1.hidden = NO;
        self.wendu1.hidden = YES;
        self.taiya1.hidden = YES;
    }else{
        self.unBinDBtn1.hidden = YES;
        self.wendu1.hidden = NO;
        self.taiya1.hidden = NO;
//        if ([CommonFunction getWheahl1wendustring]) {
//            self.wendu1.text = [CommonFunction getWheahl1wendustring];
//        }
//        
//        if ([CommonFunction getWheahl1yaliString]) {
//            self.taiya1.text = [CommonFunction getWheahl1yaliString];
//        }
        
        [self updateDataWithDatastr:mac1 index:1];

        


    }

    
    
    if (mac2.length == 0) {
        self.unBinDBtn2.hidden = NO;
        self.wendu2.hidden = YES;
        self.taiya2.hidden = YES;
    }else{
        self.unBinDBtn2.hidden = YES;
        self.wendu2.hidden = NO;
        self.taiya2.hidden = NO;
//        self.wendu2.text = @"--°C";
//        self.taiya2.text = @"--bar";
        
//        if ([CommonFunction getWheahl2wendustring]) {
//            self.wendu2.text = [CommonFunction getWheahl2wendustring];
//        }
//        
//
//        if ([CommonFunction getWheahl2yaliString]) {
//            self.taiya2.text = [CommonFunction getWheahl2yaliString];
//        }
        
        [self updateDataWithDatastr:mac2 index:2];

    }
    
    if (mac3.length == 0) {
        self.unBinDBtn3.hidden = NO;
        self.wendu3.hidden = YES;
        self.taiya3.hidden = YES;

    }else{
        self.unBinDBtn3.hidden = YES;
        self.wendu3.hidden = NO;
        self.taiya3.hidden = NO;
//        if ([CommonFunction getWheahl3wendustring]) {
//            self.wendu3.text = [CommonFunction getWheahl3wendustring];
//        }
//        
//        if ([CommonFunction getWheahl3yaliString]) {
//            self.taiya3.text = [CommonFunction getWheahl3yaliString];
//        }
        
        [self updateDataWithDatastr:mac3 index:3];

//        self.wendu3.text = @"--°C";
//        self.taiya3.text = @"--bar";
    }
    
    if (mac4.length == 0) {
        self.unBinDBtn4.hidden = NO;
        self.wendu4.hidden = YES;
        self.taiya4.hidden = YES;

    }else{
        self.unBinDBtn4.hidden = YES;
        self.wendu4.hidden = NO;
        self.taiya4.hidden = NO;
//        if ([CommonFunction getWheahl4wendustring]) {
//            self.wendu4.text = [CommonFunction getWheahl4wendustring];
//        }
//        if ([CommonFunction getWheahl4yaliString]) {
//            self.taiya4.text = [CommonFunction getWheahl4yaliString];
//        }
        
        [self updateDataWithDatastr:mac4 index:4];

//        self.wendu4.text = @"--°C";
//        self.taiya4.text = @"--bar";
    }
    
    
    //1压力过高 2压力过低 3 温度过高 5电量多低 6压力急剧下降75%
    
    
}


- (void)addtop{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
    topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topView];
    
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, WindowWidth, 1)];
    line.backgroundColor = mainColor;
    [topView addSubview:line];
    
    
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.text =@"TPMS";
    titleLable.font = [UIFont boldSystemFontOfSize:17.0];
    CGSize titleSize = [titleLable.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]}];
    titleLable.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    titleLable.center = CGPointMake(topView.center.x, 20);
    [topView addSubview:titleLable];
    titleLable.textColor = mainColor;

    
    MIBadgeButton *showLeftBtn= [[MIBadgeButton alloc]initWithFrame:CGRectMake(0, 0, 50, 43 )];
    [showLeftBtn setImage:[UIImage imageNamed:@"列表"] forState:UIControlStateNormal];
    [topView addSubview:showLeftBtn];
    showLeftBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 12, 3, 12);
    [showLeftBtn addTarget:self action:@selector(showLeftViewDidClicked:) forControlEvents:UIControlEventAllEvents];
    [showLeftBtn setBadgeString:nil];
    showLeftBtn.badgeBackgroundColor = [UIColor redColor];
    showLeftBtn.badgeEdgeInsets = UIEdgeInsetsMake(18, 0, 0, 0);
    [showLeftBtn setuobadgeLableWidth:10 height:10];
    self.showLeftBtn = showLeftBtn;
    
    


    UIButton *trackBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 45, 43)];
    if ([CommonFunction isPlayVioce]) {
        [trackBtn setImage:[UIImage imageNamed:@"音量-开"] forState:UIControlStateNormal];
    }else{
        [trackBtn setImage:[UIImage imageNamed:@"音量1-关"] forState:UIControlStateNormal];
    }
    [topView addSubview:trackBtn];
    [trackBtn addTarget:self action:@selector(trackBtn_clicked:) forControlEvents:UIControlEventTouchUpInside];
    self.trackBtn = trackBtn;
    
    
    
    
    UIImageView *bcView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64 + 20 + 20, WindowWidth, WindowHeight - 64 - 60 - 40)];
    [self.view addSubview:bcView];
    bcView.image = [UIImage imageNamed:@"组-8"];
    
    
    UIImageView *downImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, WindowHeight - 40, WindowWidth, 40)];
    downImageView.image = [UIImage imageNamed:@"提示"];
    [self.view addSubview:downImageView];
    
    
    
    
    
    
    
    self.bleStateBtn = [[UIButton alloc]init];
    [self.bleStateBtn setTitle:NSLocalizedString(@"IDS_PLEASE_OPEN_BLE", @"请打开蓝牙") forState:UIControlStateNormal];
    
    [self.bleStateBtn addTarget:self action:@selector(bleStateBtn_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.bleStateBtn];
    
    
    [self.bleStateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-3);
    }];

    
    
    //四个轮子
    //1
    self.leftUpImageView = [[UIImageView alloc]init];
    self.leftUpImageView.image = [UIImage imageNamed:@"图层-61"];
    [self.view addSubview:self.leftUpImageView];
    
    
    UILabel *qiyaAlertLable1 = [[UILabel alloc]init];
    qiyaAlertLable1.backgroundColor = [UIColor orangeColor];
    [self.leftUpImageView addSubview:qiyaAlertLable1];
    qiyaAlertLable1.textColor = [UIColor whiteColor];
    qiyaAlertLable1.text = NSLocalizedString(@"IDS_LOW_PRESSURE", @"气压低");
    qiyaAlertLable1.font = [UIFont systemFontOfSize:14.0];
    
    
    [qiyaAlertLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftUpImageView.mas_left).offset(8);
//        make.bottom.equalTo(self.leftUpImageView.mas_centerY);
        make.top.equalTo(self.leftUpImageView.mas_bottom);

        
    }];
    
    UILabel *dinaliangAlertLable1 = [[UILabel alloc]init];
    dinaliangAlertLable1.backgroundColor = [UIColor orangeColor];
    [self.leftUpImageView addSubview:dinaliangAlertLable1];
    dinaliangAlertLable1.textColor = [UIColor whiteColor];
    dinaliangAlertLable1.text = NSLocalizedString(@"IDS_LOW_BATTERY", @"电量低");
    dinaliangAlertLable1.font = [UIFont systemFontOfSize:14.0];

    
    [dinaliangAlertLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftUpImageView.mas_left).offset(8);
        //        make.bottom.equalTo(self.leftUpImageView.mas_centerY);
        make.top.equalTo(qiyaAlertLable1.mas_bottom).offset(2);
        
    }];
    
    
    UILabel *wenduAlertLable1 = [[UILabel alloc]init];
    wenduAlertLable1.backgroundColor = [UIColor orangeColor];
    [self.leftUpImageView addSubview:wenduAlertLable1];
    wenduAlertLable1.textColor = [UIColor whiteColor];
    wenduAlertLable1.text = NSLocalizedString(@"IDS_LOW_BATTERY", @"电量低");
    wenduAlertLable1.font = [UIFont systemFontOfSize:14.0];
    
    
    [wenduAlertLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftUpImageView.mas_left).offset(8);
        //        make.bottom.equalTo(self.leftUpImageView.mas_centerY);
        make.top.equalTo(dinaliangAlertLable1.mas_bottom).offset(2);

        
    }];
    
    
    UILabel *luoqiAlertLable1 = [[UILabel alloc]init];
    luoqiAlertLable1.backgroundColor = [UIColor orangeColor];
    [self.leftUpImageView addSubview:luoqiAlertLable1];
    luoqiAlertLable1.textColor = [UIColor whiteColor];
    luoqiAlertLable1.text = NSLocalizedString(@"IDS_AIR_LEAK", @"漏气");
    luoqiAlertLable1.font = [UIFont systemFontOfSize:14.0];
    
    
    [luoqiAlertLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftUpImageView.mas_left).offset(8);
        //        make.bottom.equalTo(self.leftUpImageView.mas_centerY);
        make.top.equalTo(wenduAlertLable1.mas_bottom).offset(2);
        
        
    }];
    

    [self.leftUpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100 * WindowWidth / 320.0, 100 * WindowWidth / 320.0));
        make.left.equalTo(self.view.mas_left).mas_offset(10);
        make.top.equalTo(self.view.mas_top).mas_offset(80);
    }];
    
    
    
    self.unBinDBtn1 = [[UIButton alloc]init];
    [self.unBinDBtn1 setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE", @"请绑定设备") forState:UIControlStateNormal];
    self.unBinDBtn1.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.leftUpImageView addSubview:self.unBinDBtn1];
    [self.unBinDBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.leftUpImageView.center);
    }];
    
    
    self.wendu1 = [[UILabel alloc]init];
    self.wendu1.text = @"--°C";
    self.wendu1.textColor = [UIColor whiteColor];
    [self.leftUpImageView addSubview:self.wendu1];
    [self.wendu1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftUpImageView.mas_centerX);
        make.centerY.mas_equalTo(self.leftUpImageView.mas_centerY).mas_offset(-12);
    }];
    
    
    
    self.taiya1 = [[UILabel alloc]init];
    self.taiya1.text = @"--bar";
    self.taiya1.textColor = [UIColor whiteColor];
    [self.leftUpImageView addSubview:self.taiya1];
    [self.taiya1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftUpImageView.mas_centerX);
        make.centerY.mas_equalTo(self.leftUpImageView.mas_centerY).mas_offset(12);
    }];
    

    
    
    
    //2
    self.rightUpImageView = [[UIImageView alloc]init];
    self.rightUpImageView.image = [UIImage imageNamed:@"图层-61"];
    [self.view addSubview:self.rightUpImageView];
    [self.rightUpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WindowWidth / 320.0, 100*WindowWidth / 320.0));
        make.right.equalTo(self.view.mas_right).mas_offset(-10);
        make.top.equalTo(self.view.mas_top).mas_offset(80);
    }];
    
    
    
    UILabel *qiyaAlertLable2 = [[UILabel alloc]init];
    qiyaAlertLable2.backgroundColor = [UIColor orangeColor];
    [self.rightUpImageView addSubview:qiyaAlertLable2];
    qiyaAlertLable2.textColor = [UIColor whiteColor];
    qiyaAlertLable2.text = NSLocalizedString(@"IDS_LOW_PRESSURE", @"气压低");
    qiyaAlertLable2.font = [UIFont systemFontOfSize:14.0];
    
    
    [qiyaAlertLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightUpImageView.mas_right).offset(-8);
        make.top.equalTo(self.rightUpImageView.mas_bottom);
        
    }];
    
    UILabel *dinaliangAlertLable2 = [[UILabel alloc]init];
    dinaliangAlertLable2.backgroundColor = [UIColor orangeColor];
    [self.rightUpImageView addSubview:dinaliangAlertLable2];
    dinaliangAlertLable2.textColor = [UIColor whiteColor];
    dinaliangAlertLable2.text =NSLocalizedString(@"IDS_LOW_BATTERY", @"电量低");
    dinaliangAlertLable2.font = [UIFont systemFontOfSize:14.0];
    
    
    [dinaliangAlertLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightUpImageView.mas_right).offset(-8);
        make.top.equalTo(qiyaAlertLable2.mas_bottom).offset(2);
        
    }];
    
    
    UILabel *wenduAlertLable2 = [[UILabel alloc]init];
    wenduAlertLable2.backgroundColor = [UIColor orangeColor];
    [self.rightUpImageView addSubview:wenduAlertLable2];
    wenduAlertLable2.textColor = [UIColor whiteColor];
    wenduAlertLable2.text = NSLocalizedString(@"IDS_LOW_BATTERY", @"电量低");
    wenduAlertLable2.font = [UIFont systemFontOfSize:14.0];
    
    
    [wenduAlertLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightUpImageView.mas_right).offset(-8);
        make.top.equalTo(dinaliangAlertLable2.mas_bottom).offset(2);
        
    }];
    
    
    
    
    UILabel *luoqiAlertLable2 = [[UILabel alloc]init];
    luoqiAlertLable2.backgroundColor = [UIColor orangeColor];
    [self.rightUpImageView addSubview:luoqiAlertLable2];
    luoqiAlertLable2.textColor = [UIColor whiteColor];
    luoqiAlertLable2.text = NSLocalizedString(@"IDS_AIR_LEAK", @"漏气");
    luoqiAlertLable2.font = [UIFont systemFontOfSize:14.0];
    
    
    [luoqiAlertLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightUpImageView.mas_right).offset(-8);
        make.top.equalTo(wenduAlertLable2.mas_bottom).offset(2);
        
    }];

    
    
    
    self.unBinDBtn2 = [[UIButton alloc]init];
    [self.unBinDBtn2 setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE", @"请绑定设备") forState:UIControlStateNormal];
    self.unBinDBtn2.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.rightUpImageView addSubview:self.unBinDBtn2];
    [self.unBinDBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.rightUpImageView.center);
    }];
    
    
    self.wendu2 = [[UILabel alloc]init];
    self.wendu2.text = @"--°C";
    self.wendu2.textColor = [UIColor whiteColor];
    [self.rightUpImageView addSubview:self.wendu2];
    [self.wendu2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rightUpImageView.mas_centerX);
        make.centerY.mas_equalTo(self.rightUpImageView.mas_centerY).mas_offset(-12);
    }];
    
    
    
    self.taiya2 = [[UILabel alloc]init];
    self.taiya2.text = @"--bar";
    self.taiya2.textColor = [UIColor whiteColor];
    [self.rightUpImageView addSubview:self.taiya2];
    [self.taiya2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rightUpImageView.mas_centerX);
        make.centerY.mas_equalTo(self.rightUpImageView.mas_centerY).mas_offset(12);
    }];

    
    
    
    //3
    self.leftDownImageView = [[UIImageView alloc]init];
    self.leftDownImageView.image = [UIImage imageNamed:@"图层-61"];
    [self.view addSubview:self.leftDownImageView];
    [self.leftDownImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WindowWidth / 320.0, 100*WindowWidth / 320.0));
        make.left.equalTo(self.view.mas_left).mas_offset(10);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-50);
    }];
    
    
    
    UILabel *qiyaAlertLable3 = [[UILabel alloc]init];
    qiyaAlertLable3.backgroundColor = [UIColor orangeColor];
    [self.leftDownImageView addSubview:qiyaAlertLable3];
    qiyaAlertLable3.textColor = [UIColor whiteColor];
    qiyaAlertLable3.text = NSLocalizedString(@"IDS_LOW_PRESSURE", @"气压低");
    qiyaAlertLable3.font = [UIFont systemFontOfSize:14.0];
    
    
    [qiyaAlertLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftDownImageView.mas_left).offset(8);
        make.bottom.equalTo(self.leftDownImageView.mas_top);
        
    }];
    
    UILabel *dinaliangAlertLable3 = [[UILabel alloc]init];
    dinaliangAlertLable3.backgroundColor = [UIColor orangeColor];
    [self.leftDownImageView addSubview:dinaliangAlertLable3];
    dinaliangAlertLable3.textColor = [UIColor whiteColor];
    dinaliangAlertLable3.text = NSLocalizedString(@"IDS_LOW_BATTERY", @"电量低");
    dinaliangAlertLable3.font = [UIFont systemFontOfSize:14.0];
    
    
    [dinaliangAlertLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftDownImageView.mas_left).offset(8);
        make.bottom.equalTo(qiyaAlertLable3.mas_top).offset(-2);
        
    }];
    
    
    UILabel *wenduAlertLable3 = [[UILabel alloc]init];
    wenduAlertLable3.backgroundColor = [UIColor orangeColor];
    [self.leftDownImageView addSubview:wenduAlertLable3];
    wenduAlertLable3.textColor = [UIColor whiteColor];
    wenduAlertLable3.text = NSLocalizedString(@"IDS_LOW_BATTERY", @"电量低");
    wenduAlertLable3.font = [UIFont systemFontOfSize:14.0];
    
    
    [wenduAlertLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftDownImageView.mas_left).offset(8);
        make.bottom.equalTo(dinaliangAlertLable3.mas_top).offset(-2);
    }];
    
    
    UILabel *luoqiAlertLable3 = [[UILabel alloc]init];
    luoqiAlertLable3.backgroundColor = [UIColor orangeColor];
    [self.leftDownImageView addSubview:luoqiAlertLable3];
    luoqiAlertLable3.textColor = [UIColor whiteColor];
    luoqiAlertLable3.text = NSLocalizedString(@"IDS_AIR_LEAK", @"漏气");
    luoqiAlertLable3.font = [UIFont systemFontOfSize:14.0];
    
    
    [luoqiAlertLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftDownImageView.mas_left).offset(8);
        make.bottom.equalTo(wenduAlertLable3.mas_top).offset(-2);
    }];
    
    
    self.unBinDBtn3 = [[UIButton alloc]init];
    [self.unBinDBtn3 setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE", @"请绑定设备") forState:UIControlStateNormal];
    self.unBinDBtn3.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.leftDownImageView addSubview:self.unBinDBtn3];
    [self.unBinDBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.leftDownImageView.center);
    }];
    
    
    self.wendu3 = [[UILabel alloc]init];
    self.wendu3.text = @"--°C";
    self.wendu3.textColor = [UIColor whiteColor];
    [self.leftDownImageView addSubview:self.wendu3];
    [self.wendu3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftDownImageView.mas_centerX);
        make.centerY.mas_equalTo(self.leftDownImageView.mas_centerY).mas_offset(-12);
    }];
    
    
    
    self.taiya3 = [[UILabel alloc]init];
    self.taiya3.text = @"--bar";
    self.taiya3.textColor = [UIColor whiteColor];
    [self.leftDownImageView addSubview:self.taiya3];
    [self.taiya3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftDownImageView.mas_centerX);
        make.centerY.mas_equalTo(self.leftDownImageView.mas_centerY).mas_offset(12);
    }];

    
    
    
    //4
    self.rightDownImageView = [[UIImageView alloc]init];
    self.rightDownImageView.image = [UIImage imageNamed:@"图层-61"];
    [self.view addSubview:self.rightDownImageView];
    [self.rightDownImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WindowWidth / 320.0, 100*WindowWidth / 320.0));
        make.right.equalTo(self.view.mas_right).mas_offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-50);
    }];
    
    
    
    UILabel *qiyaAlertLable4 = [[UILabel alloc]init];
    qiyaAlertLable4.backgroundColor = [UIColor orangeColor];
    [self.rightDownImageView addSubview:qiyaAlertLable4];
    qiyaAlertLable4.textColor = [UIColor whiteColor];
    qiyaAlertLable4.text = NSLocalizedString(@"IDS_LOW_PRESSURE", @"气压低");
    qiyaAlertLable4.font = [UIFont systemFontOfSize:14.0];
    
    
    [qiyaAlertLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightDownImageView.mas_right).offset(-8);
        make.bottom.equalTo(self.rightDownImageView.mas_top);
        
    }];
    
    UILabel *dinaliangAlertLable4 = [[UILabel alloc]init];
    dinaliangAlertLable4.backgroundColor = [UIColor orangeColor];
    [self.rightDownImageView addSubview:dinaliangAlertLable4];
    dinaliangAlertLable4.textColor = [UIColor whiteColor];
    dinaliangAlertLable4.text = NSLocalizedString(@"IDS_LOW_BATTERY", @"电量低");
    dinaliangAlertLable4.font = [UIFont systemFontOfSize:14.0];
    
    
    [dinaliangAlertLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightDownImageView.mas_right).offset(-8);
        make.bottom.equalTo(qiyaAlertLable4.mas_top).offset(-2);
        
    }];
    
    
    UILabel *wenduAlertLable4 = [[UILabel alloc]init];
    wenduAlertLable4.backgroundColor = [UIColor orangeColor];
    [self.rightDownImageView addSubview:wenduAlertLable4];
    wenduAlertLable4.textColor = [UIColor whiteColor];
    wenduAlertLable4.text = NSLocalizedString(@"IDS_LOW_BATTERY", @"电量低");
    wenduAlertLable4.font = [UIFont systemFontOfSize:14.0];
    [wenduAlertLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightDownImageView.mas_right).offset(-8);
        make.bottom.equalTo(dinaliangAlertLable4.mas_top).offset(-2);
        
    }];
    
    
    UILabel *luoqiAlertLable4 = [[UILabel alloc]init];
    luoqiAlertLable4.backgroundColor = [UIColor orangeColor];
    [self.rightDownImageView addSubview:luoqiAlertLable4];
    luoqiAlertLable4.textColor = [UIColor whiteColor];
    luoqiAlertLable4.text = NSLocalizedString(@"IDS_AIR_LEAK", @"漏气");
    luoqiAlertLable4.font = [UIFont systemFontOfSize:14.0];
    
    
    [luoqiAlertLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightDownImageView.mas_right).offset(-8);
        make.bottom.equalTo(wenduAlertLable4.mas_top).offset(-2);
        
    }];
    
    
    self.unBinDBtn4 = [[UIButton alloc]init];
    [self.unBinDBtn4 setTitle:NSLocalizedString(@"IDS_PLEASE_BIND_DEVICE", @"请绑定设备")  forState:UIControlStateNormal];
    self.unBinDBtn4.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.rightDownImageView addSubview:self.unBinDBtn4];
    [self.unBinDBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.rightDownImageView.center);
    }];
    
    
    self.wendu4 = [[UILabel alloc]init];
    self.wendu4.text = @"--°C";
    self.wendu4.textColor = [UIColor whiteColor];
    [self.rightDownImageView addSubview:self.wendu4];
    [self.wendu4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rightDownImageView.mas_centerX);
        make.centerY.mas_equalTo(self.rightDownImageView.mas_centerY).mas_offset(-12);
    }];
    
    
    
    self.taiya4 = [[UILabel alloc]init];
    self.taiya4.text = @"--bar";
    self.taiya4.textColor = [UIColor whiteColor];
    [self.rightDownImageView addSubview:self.taiya4];
    [self.taiya4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rightDownImageView.mas_centerX);
        make.centerY.mas_equalTo(self.rightDownImageView.mas_centerY).mas_offset(12);
    }];

        

    
    

    //左侧视图
    UIView *maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.maskView = maskView;
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    [self.view addSubview:maskView];
    UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskTap:)];
    [maskView addGestureRecognizer:maskTap];
    UISwipeGestureRecognizer *maskSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(maskTap:)];
    maskSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [maskView addGestureRecognizer:maskSwipe];
    
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (WindowWidth - TopViewRightWidth), WindowHeight)];
    self.leftView = leftView;
    self.leftView.center = CGPointMake(-(WindowWidth - TopViewRightWidth)/2, WindowHeight/2);
    [self.view addSubview:leftView];
    leftView.backgroundColor = [UIColor blackColor];
    
    UIButton *leftBackBtn = [[UIButton alloc]init];
    [leftBackBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftBackBtn addTarget:self action:@selector(leftBackBtn_clicked) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftBackBtn];
    [leftBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView.mas_top).offset(30);
        make.left.equalTo(leftView.mas_left).offset(8);
    }];
    
    UITableView *leftTableView = [[UITableView alloc]init];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.backgroundColor = [UIColor blackColor];
    leftTableView.tableFooterView = [[UIView alloc]init];
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftTableView.rowHeight = 60;
    [leftView addSubview:leftTableView];
    [leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftBackBtn.mas_bottom);
        make.left.equalTo(leftView.mas_left);
        make.right.equalTo(leftView.mas_right);
        make.bottom.equalTo(leftView.mas_bottom);
    }];
    
    
    
    

    self.unBinDBtn1.tag = 1;
    self.unBinDBtn2.tag = 2;
    self.unBinDBtn3.tag = 3;
    self.unBinDBtn4.tag = 4;

    
    
    
    [self.unBinDBtn1 addTarget:self action:@selector(unbindClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.unBinDBtn2 addTarget:self action:@selector(unbindClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.unBinDBtn3 addTarget:self action:@selector(unbindClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.unBinDBtn4 addTarget:self action:@selector(unbindClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.unBinDBtn1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.unBinDBtn2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.unBinDBtn3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.unBinDBtn4 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];



    _leftUpImageView.userInteractionEnabled = YES;
    _leftDownImageView.userInteractionEnabled = YES;
    _rightUpImageView.userInteractionEnabled = YES;
    _rightDownImageView.userInteractionEnabled = YES;


    
    
    self.qiyaAlertLable1 = qiyaAlertLable1;
    self.dinaliangAlertLable1 = dinaliangAlertLable1;
    self.wenduAlertLable1 = wenduAlertLable1;

    
    self.qiyaAlertLable2 = qiyaAlertLable2;
    self.dinaliangAlertLable2 = dinaliangAlertLable2;
    self.wenduAlertLable2 = wenduAlertLable2;
    
    self.qiyaAlertLable3 = qiyaAlertLable3;
    self.dinaliangAlertLable3 = dinaliangAlertLable3;
    self.wenduAlertLable3 = wenduAlertLable3;
    
    self.qiyaAlertLable4 = qiyaAlertLable4;
    self.dinaliangAlertLable4 = dinaliangAlertLable4;
    self.wenduAlertLable4 = wenduAlertLable4;
    
    self.luoqiAlertLable1 = luoqiAlertLable1;
    self.luoqiAlertLable2 = luoqiAlertLable2;
    self.luoqiAlertLable3 = luoqiAlertLable3;
    self.luoqiAlertLable4 = luoqiAlertLable4;

    
    
    self.qiyaAlertLable1.hidden = YES;
    self.dinaliangAlertLable1.hidden = YES;
    self.wenduAlertLable1.hidden = YES;
    
    
    self.qiyaAlertLable2.hidden = YES;
    self.dinaliangAlertLable2.hidden = YES;
    self.wenduAlertLable2.hidden = YES;
    
    self.qiyaAlertLable3.hidden = YES;
    self.dinaliangAlertLable3.hidden = YES;
    self.wenduAlertLable3.hidden = YES;
    
    self.qiyaAlertLable4.hidden = YES;
    self.dinaliangAlertLable4.hidden = YES;
    self.wenduAlertLable4.hidden = YES;
    
    self.luoqiAlertLable1.hidden = YES;
    self.luoqiAlertLable2.hidden = YES;
    self.luoqiAlertLable3.hidden = YES;
    self.luoqiAlertLable4.hidden = YES;

   
    
}

- (void)showLeftViewDidClicked:(UIButton *)sender
{
    for (UIView *view  in self.view.subviews) {
        if (view.tag == 1) {
            [view removeFromSuperview];
            break;
        }
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.leftView.center = CGPointMake((WindowWidth - TopViewRightWidth)/2, WindowHeight/2);
        self.maskView.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
}


- (void)trackBtn_clicked:(UIButton *)btn{

    if ([CommonFunction isPlayVioce]) {
        [CommonFunction setisPlayVioce:NO];
        [btn setImage:[UIImage imageNamed:@"音量1-关"] forState:UIControlStateNormal];

    }else{
        [CommonFunction setisPlayVioce:YES];
        [btn setImage:[UIImage imageNamed:@"音量-开"] forState:UIControlStateNormal];
    }
    
    
   
}

- (void)maskTap:(UITapGestureRecognizer *)recognizer
{
    [self.showLeftBtn setBadgeString:nil];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.maskView.alpha = 0;
        self.leftView.center = CGPointMake(-(WindowWidth - TopViewRightWidth)/2, WindowHeight/2);
    } completion:^(BOOL finished) {
    }];
}


#pragma mark CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    if(central.state == CBManagerStatePoweredOn)
    {
        [self.bleStateBtn setTitle:NSLocalizedString(@"IDS_BLE_OPEN", @"蓝牙开启")  forState:UIControlStateNormal];
        [self.bleStateBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.centralmanager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"FBB0"]]  options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
//
    }else{

        [self.bleStateBtn setTitle:NSLocalizedString(@"IDS_PLEASE_OPEN_BLE", @"请打开蓝牙") forState:UIControlStateNormal];
        [self.bleStateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
}




-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    

    
    NSDictionary *dic = advertisementData;
    
    if ([dic objectForKey:@"kCBAdvDataManufacturerData"]) {
        
        NSData *data = [dic objectForKey:@"kCBAdvDataManufacturerData"];
        NSString *str = [self convertDataToHexStr:data];

        
        
        //丢弃相同的包
        if ([self.lastadvertisementData isEqualToString:str]){
            return;
        }else{
            self.lastadvertisementData = str;
        }
        
        NSLog(@"收到数据包%@",str);

        
        if (str.length == 36 || str.length == 34) {
            
            NSString *macStr = [str substringWithRange:NSMakeRange(4, 12)];

            if ( [self isSameMacStr:[macStr uppercaseString] withMacString:[CommonFunction wheal1MacString]]) {
                
                //            self.wendu1.text = wenduString;
                //            self.taiya1.text = yaliString;
                //            self.wendu1.hidden = NO;
                //            self.taiya1.hidden = NO;
                //            self.unBinDBtn1.hidden = YES;
                //            [CommonFunction setWheahl1wendustring:wenduString yaliString:yaliString];
                //            [self updateDataWithyalifloat:yalifloat wenduinter:wenduinter dianliangInter:dianliangInter index:1];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(whealTimer1) object:nil];
                    [self performSelector:@selector(whealTimer1) withObject:nil afterDelay:60 * 10];
                    
                });
                
                [CommonFunction setWheahl1DataString:str];
                [self updateDataWithDatastr:str index:1];
                
                
                
                
            }else if([self isSameMacStr:[macStr uppercaseString] withMacString:[CommonFunction wheal2MacString]]){
                
                //            self.wendu2.text = wenduString;
                //            self.taiya2.text = yaliString;
                //            self.wendu2.hidden = NO;
                //            self.taiya2.hidden = NO;
                //            self.unBinDBtn2.hidden = YES;
                //            [CommonFunction setWheahl2wendustring:wenduString yaliString:yaliString];
                
                //            [self updateDataWithyalifloat:yalifloat wenduinter:wenduinter dianliangInter:dianliangInter index:2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(whealTimer2) object:nil];
                    [self performSelector:@selector(whealTimer2) withObject:nil afterDelay:60 * 10];
                    
                });
                [CommonFunction setWheahl2DataString:str];
                [self updateDataWithDatastr:str index:2];
                
                
            }else if([self isSameMacStr:[macStr uppercaseString] withMacString:[CommonFunction wheal3MacString]]){
                
                //            self.wendu3.text = wenduString;
                //            self.taiya3.text = yaliString;
                //            self.wendu3.hidden = NO;
                //            self.taiya3.hidden = NO;
                //            self.unBinDBtn3.hidden = YES;
                //            [CommonFunction setWheahl3wendustring:wenduString yaliString:yaliString];
                
                //            [self updateDataWithyalifloat:yalifloat wenduinter:wenduinter dianliangInter:dianliangInter index:3];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(whealTimer3) object:nil];
                    [self performSelector:@selector(whealTimer3) withObject:nil afterDelay:60 * 10];
                    
                });
                [CommonFunction setWheahl3DataString:str];
                [self updateDataWithDatastr:str index:3];
                
                
                
            }else if([self isSameMacStr:[macStr uppercaseString] withMacString:[CommonFunction wheal4MacString]]){
                
                //            self.wendu4.text = wenduString;
                //            self.taiya4.text = yaliString;
                //            self.wendu4.hidden = NO;
                //            self.taiya4.hidden = NO;
                //            self.unBinDBtn4.hidden = YES;
                //            [CommonFunction setWheahl4wendustring:wenduString yaliString:yaliString];
                
                //            [self updateDataWithyalifloat:yalifloat wenduinter:wenduinter dianliangInter:dianliangInter index:4];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(whealTimer4) object:nil];
                    [self performSelector:@selector(whealTimer4) withObject:nil afterDelay:60 * 10];
                    
                });
                [CommonFunction setWheahl4DataString:str];
                [self updateDataWithDatastr:str index:4];
                
                
                
            }
            
        }
        }
        

    
        
        
        
        
        
        
}


- (void)whealTimer1{
    if ([CommonFunction getWheahl1DataString]) {
        self.wendu1.text = @"--°C";
        self.taiya1.text = @"--bar";
    }
}


- (void)whealTimer2{
    if ([CommonFunction getWheahl2DataString]) {
        self.wendu2.text = @"--°C";
        self.taiya2.text = @"--bar";
    }
}


- (void)whealTimer3{
    if ([CommonFunction getWheahl3DataString]) {
        self.wendu3.text = @"--°C";
        self.taiya3.text = @"--bar";
    }
}

- (void)whealTimer4{
    if ([CommonFunction getWheahl4DataString]) {
        self.wendu4.text = @"--°C";
        self.taiya4.text = @"--bar";
    }
}

- (void)updateDataWithDatastr:(NSString *)dataStr index:(NSInteger)index{
    
    NSString *yaliString  =[dataStr substringWithRange:NSMakeRange(16, 8)];
    CGFloat yalifloat = [[self getValueofstr:yaliString] integerValue]* 0.00001;
    yaliString = [NSString stringWithFormat:@"%.1fbar",yalifloat];
    
    if ([[CommonFunction yalidanwei] isEqualToString:@"Psi"])  {
        yalifloat = yalifloat  * BarToPsi;
        yaliString = [NSString stringWithFormat:@"%.1fPsi",yalifloat];
    }else if([[CommonFunction yalidanwei] isEqualToString:@"Kpa"]){
        yalifloat = yalifloat  * BarToKpa;
        yaliString = [NSString stringWithFormat:@"%.1fKpa",yalifloat ];
    }
    
    
    
    NSString *wenduString  =[dataStr substringWithRange:NSMakeRange(24, 8)];
    CGFloat wenduinter = [[self getValueofstr:wenduString] integerValue] * 0.01;
    wenduString = [NSString stringWithFormat:@"%.1f°C",wenduinter];
    if ([[CommonFunction wendudanwei] isEqualToString:@"°F"]) {
        wenduinter = wenduinter * 1.8 + 32;
        wenduString = [NSString stringWithFormat:@"%.1f°F",wenduinter];
    }
    
    
    NSString *dianliangString  =[dataStr substringWithRange:NSMakeRange(32, 2)];
    NSInteger dianliangInter = strtoul([dianliangString UTF8String],0,16);
    dianliangString = [NSString stringWithFormat:@"%lu",(long)dianliangInter];

    
    
    [self updateDataWithyalifloat:yalifloat wenduinter:wenduinter dianliangInter:dianliangInter index:index yaliString:yaliString wenduString:wenduString datastring:dataStr] ;
}

- (void)updateDataWithyalifloat:(CGFloat)yalifloat wenduinter:(NSInteger)wenduinter dianliangInter:(NSInteger)dianliangInter index:(NSInteger)index yaliString:(NSString *)yaliString wenduString:(NSString *)wenduString datastring:(NSString *)dataString{
    
    UIImageView *imageView;
    NSString *str;
    UILabel *yaliAlertLable;
    UILabel *dianliangAlertLable;
    UILabel *wenduAlertLable;
    UILabel *wenduLable;
    UILabel *yaliLable;
    UILabel *luoqiLable;

    UIButton *unbindBtn;

    switch (index) {
        case 1:
            imageView = self.leftUpImageView;
            str = @"左前";
            yaliAlertLable = self.qiyaAlertLable1;
            dianliangAlertLable = self.dinaliangAlertLable1;
            wenduAlertLable = self.wenduAlertLable1;
            wenduLable = self.wendu1;
            yaliLable = self.taiya1;
            unbindBtn = self.unBinDBtn1;
            luoqiLable = self.luoqiAlertLable1;
            break;
        case 2:
            imageView = self.rightUpImageView;
            str = @"右前";
            yaliAlertLable = self.qiyaAlertLable2;
            dianliangAlertLable = self.dinaliangAlertLable2;
            wenduAlertLable = self.wenduAlertLable2;
            wenduLable = self.wendu2;
            yaliLable = self.taiya2;
            unbindBtn = self.unBinDBtn2;
            luoqiLable = self.luoqiAlertLable2;




            break;
        case 3:
            imageView = self.leftDownImageView;
            str = @"左后";
            yaliAlertLable = self.qiyaAlertLable3;
            dianliangAlertLable = self.dinaliangAlertLable3;
            wenduAlertLable = self.wenduAlertLable3;
            wenduLable = self.wendu3;
            yaliLable = self.taiya3;
            unbindBtn = self.unBinDBtn3;
            luoqiLable = self.luoqiAlertLable3;



            break;
        case 4:
            imageView = self.rightDownImageView;
            str = @"右后";
            yaliAlertLable = self.qiyaAlertLable4;
            dianliangAlertLable = self.dinaliangAlertLable4;
            wenduAlertLable = self.wenduAlertLable4;
            wenduLable = self.wendu4;
            yaliLable = self.taiya4;
            unbindBtn = self.unBinDBtn4;
            luoqiLable = self.luoqiAlertLable3;


            break;
            
        default:
            break;
    }
    
    
    
    wenduLable.text = wenduString;
    yaliLable.text = yaliString;
    yaliLable.hidden = NO;
    wenduLable.hidden = NO;
    unbindBtn.hidden = YES;
    
    
    
    BOOL isInTrouble = NO;
    
    //压力
    if (yalifloat > [CommonFunction defaultYaliShang]) {
        
        [self judgeHasContain:str];
        
        NSString *yichangStr = [NSString stringWithFormat:@"%@轮胎气压过高",str];
        [self judgeHasContain:yichangStr];
        isInTrouble = YES;
        yaliAlertLable.text =NSLocalizedString(@"IDS_HIGH_PRESSURE", @"气压过高");
        yaliAlertLable.hidden = NO;
        yaliLable.textColor = [UIColor orangeColor];
        NSLog(@"气压过高");
        
    }else if (yalifloat < [CommonFunction defaultYaliXia]) {
        
        NSString *yichangStr = [NSString stringWithFormat:@"%@轮胎气压过低",str];
        [self judgeHasContain:yichangStr];

        isInTrouble = YES;
        yaliAlertLable.text =NSLocalizedString(@"IDS_LOW_PRESSURE", @"气压过低");
        yaliAlertLable.hidden = NO;
        yaliLable.textColor = [UIColor orangeColor];
        NSLog(@"气压过低");
        
    }else{
        yaliLable.textColor = [UIColor whiteColor];
        yaliAlertLable.hidden = YES;
        
        
        NSString *yalizhengchang = [NSString stringWithFormat:@"%@轮胎气压",str];
        
        [self changetozhengchang:yalizhengchang];
        
        


    }
    
    //温度
    if (wenduinter > [CommonFunction defaultWenduShang]) {
    
        NSString *yichangStr = [NSString stringWithFormat:@"%@轮胎温度过高",str];
        [self judgeHasContain:yichangStr];

        isInTrouble = YES;
        wenduAlertLable.text = NSLocalizedString(@"IDS_GIGH_TEMPERTURE", @"温度过高");
        wenduAlertLable.hidden = NO;
        NSLog(@"温度过高");
        wenduLable.textColor = [UIColor orangeColor];
    }else{
        wenduLable.textColor = [UIColor whiteColor];
        wenduAlertLable.hidden = YES;
        
        
        NSString *yalizhengchang = [NSString stringWithFormat:@"%@轮胎温度",str];
        
        [self changetozhengchang:yalizhengchang];
    }
    
    //电量
    if (dianliangInter < [CommonFunction defaultdianliangXia]) {
//        [self.voiceArr addObject:[NSString stringWithFormat:@"%@轮胎电量过低",str]];
//        [self reloadTimer];
        
        NSString *yichangStr = [NSString stringWithFormat:@"%@轮胎电量过低",str];
        [self judgeHasContain:yichangStr];

        isInTrouble = YES;
        dianliangAlertLable.text = NSLocalizedString(@"IDS_LOW_BATTERY", @"电量过低");
        dianliangAlertLable.hidden = NO;
        NSLog(@"电量过低");

    }else{
        dianliangAlertLable.hidden = YES;
        
        NSString *yalizhengchang = [NSString stringWithFormat:@"%@轮胎电量",str];
        
        [self changetozhengchang:yalizhengchang];

    }
    
    
    
//    //漏气
    
    
    if (dataString.length == 36) {
        NSString *luoqiString  =[dataString substringWithRange:NSMakeRange(34, 2)];
        NSInteger luoqiStringInter = strtoul([luoqiString UTF8String],0,16);
        
        
        if (luoqiStringInter == 1) {
            //        [self.voiceArr addObject:[NSString stringWithFormat:@"%@轮胎电量过低",str]];
            //        [self reloadTimer];
            
            NSString *yichangStr = [NSString stringWithFormat:@"%@轮胎漏气",str];
            [self judgeHasContain:yichangStr];
            
            isInTrouble = YES;
            luoqiLable.text = NSLocalizedString(@"IDS_AIR_LEAK", @"漏气");
            luoqiLable.hidden = NO;
            NSLog(@"漏气");
            
        }else{
            luoqiLable.hidden = YES;
            
            NSString *yalizhengchang = [NSString stringWithFormat:@"%@轮胎漏气",str];
            
            [self changetozhengchang:yalizhengchang];
            
        }

    }

   
    
   
    
    //轮胎颜色
    NSData *img1Data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blue" ofType:@"gif"]];
    
    NSData *img2Data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"orange" ofType:@"gif"]];

    
    if (isInTrouble) {
        
        imageView.image =   [AnimatedGIFImageSerialization imageWithData:img2Data error:nil];
        
    }else{
        
        
        imageView.image =   [AnimatedGIFImageSerialization imageWithData:img1Data error:nil];
        
        NSMutableArray *tempVoiceArr = [self.voiceArr mutableCopy];
        for (NSString *voiceName in self.voiceArr) {
            
            if ([voiceName containsString:str]) {
                [tempVoiceArr removeObject:voiceName];
            }
            
        }
        self.voiceArr = tempVoiceArr;
        [self reloadTimer];

    }

}


//异常变为正常
- (void)changetozhengchang:(NSString *)str{


//    NSLog(@"恢复正常:%@",str);
//    NSLog(@"恢复正常%@",self.voiceArr);
    
    for (NSString *voiceName  in self.voiceArr.reverseObjectEnumerator) {
        if ([voiceName containsString:str]) {
            [self.voiceArr removeObject:voiceName];
            [self reloadTimer];
            return;
        }
    }
    
    

    
}

- (void)judgeHasContain:(NSString *)yichangName{
    
    BOOL hasContain = NO;
    for (NSString *str  in self.voiceArr) {
        if ([str containsString:yichangName]) {
            hasContain = YES;
        }
    }
    if (!hasContain) {
        [self.voiceArr addObject:yichangName];
        [self reloadTimer];
    }
    
}


- (void)reloadTimer{
    
//    NSLog(@"重新加载timer");
    
    [self.timer invalidate];
    self.timer = nil;
    
    if (self.voiceArr > 0) {
        
        self.timer =   [NSTimer scheduledTimerWithTimeInterval:self.voiceArr.count * 2 target:self selector:@selector(playVoice) userInfo:nil repeats:YES];
    }
    
    

}


- (NSString *)getValueofstr:(NSString *)str{

   NSString *yaliString = [NSString stringWithFormat:@"%@%@%@",[str substringWithRange:NSMakeRange(4, 2)],[str substringWithRange:NSMakeRange(2, 2)],[str substringWithRange:NSMakeRange(0, 2)]];
    yaliString =[NSString stringWithFormat:@"%lu",strtoul([yaliString UTF8String],0,16)];
    return yaliString;
}




- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

#pragma mark noti
- (void)UnitChangeNoti{
    
    [self updateView];
//    sdhvs
#warning joe
}


#pragma mark sender
- (void)leftBackBtn_clicked{
    
    
    [self.showLeftBtn setBadgeString:nil];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.maskView.alpha = 0;
        self.leftView.center = CGPointMake(-(WindowWidth - TopViewRightWidth)/2, WindowHeight/2);
    } completion:^(BOOL finished) {
    }];

    
    
}


- (void)unbindClick:(UIButton *)btn{
    
    BindDeviceView *bindView = [[BindDeviceView alloc]init];
    bindView.tag = btn.tag;
    bindView.delegate = self;
    [self.view addSubview:bindView];
    
}


- (void)bleStateBtn_clicked{
    
    
    if ([self.bleStateBtn.titleLabel.text isEqualToString:NSLocalizedString(@"IDS_PLEASE_OPEN_BLE", @"请打开蓝牙")]) {
        
        NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
        }else{
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        
    }
}

#pragma mark BindDeviceViewDelegate
- (void)certainClickView:(BindDeviceView *)view text:(NSString *)text{
    
    
    switch (view.tag) {
        case 1:
            [CommonFunction setWheahlmacstring:[NSString stringWithFormat:@"800000%@",text]];
            break;
        case 2:
            [CommonFunction setWheah2macstring:[NSString stringWithFormat:@"810000%@",text]];

            break;
        case 3:
            [CommonFunction setWheah3macstring:[NSString stringWithFormat:@"820000%@",text]];

            break;
        case 4:
            [CommonFunction setWheah4macstring:[NSString stringWithFormat:@"830000%@",text]];

            break;
        default:
            break;
    }
    
    
    [self updateView];
    
}


#pragma mark uitableViewDelegate&dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor blackColor];
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"首页-首页"];
            cell.textLabel.text =NSLocalizedString(@"IDS_HOME", @"首页");
            cell.textLabel.textColor = [UIColor orangeColor];
             break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"机器人"];
            cell.textLabel.text = NSLocalizedString(@"IDS_BIND_NEW_DEVICE", @"绑定新设备");
            cell.textLabel.textColor = mainColor;

            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"设置"];
            cell.textLabel.text = NSLocalizedString(@"IDS_SYSTEM_SETTING", @"系统设置");
            cell.textLabel.textColor = mainColor;

            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"帮助"];
            cell.textLabel.text = NSLocalizedString(@"IDS_HELP", @"帮助");
            cell.textLabel.textColor = mainColor;
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0:
            [self leftBackBtn_clicked];
            break;
        case 1:{
            BindNewDeviceViewController *vc = [[BindNewDeviceViewController alloc]initWithNibName:@"BindNewDeviceViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            SystemSettingViewController * vc = [[SystemSettingViewController alloc]initWithNibName:@"SystemSettingViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            HelpViewController * vc = [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }

    
}


#pragma UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        
        
        if([[UIDevice currentDevice].systemVersion doubleValue] > 9.0){
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }else{
            NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                [[UIApplication sharedApplication]openURL:url];
            }
        }
        
        
    }
}



- (BOOL)isSameMacStr:(NSString *)str withMacString:(NSString *)macString{
    
    
    
    if (!macString) {
        return NO;
    }
    
    
    NSString *preStr1 = [str substringWithRange:NSMakeRange(0, 2)];
    NSString *preStr2 = [macString substringWithRange:NSMakeRange(0, 2)];

    NSString *suffixStr1 = [str substringWithRange:NSMakeRange(6, 6)];
    NSString *suffixStr2 = [macString substringWithRange:NSMakeRange(6, 6)];

    
    if ([preStr1 isEqualToString:preStr2] && [suffixStr1 isEqualToString:suffixStr2]) {
//        NSLog(@"搜到的Mac 地址:%@",str);
//        NSLog(@"比较的Mac 地址:%@",macString);
        return YES;
    }
    
    
    return NO;
    
}



@end
